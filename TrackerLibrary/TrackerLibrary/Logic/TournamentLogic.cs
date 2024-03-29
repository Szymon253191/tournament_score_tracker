﻿using iText.Layout.Splitting;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Runtime.InteropServices;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using TrackerLibrary.DataAccess;
using TrackerLibrary.Model;

namespace TrackerLibrary
{
    public static class TournamentLogic
    {
        // Order list randomly 
        // Check if its big enough - if not, add in byes. 2^n - number of teams needed for full tournament
        // Create first round of mathchup
        // Create every round after first one. 8 matchups -> 4 matchups -> 2 matchups -> 1 matchup

        public static void CreateRounds(TournamentModel model)
        {
            List<TeamModel> randomizedTeams = RandomizeTeamOrder(model.EnteredTeams);
            int rounds = FindNumberOfRounds(randomizedTeams.Count);
            int byes = NumberOfByes(rounds, randomizedTeams.Count);

            model.Rounds.Add(CreateFirstRound(byes, randomizedTeams));

            CreateOtherRounds(model, rounds);
        }

        public static void UpdateTournamentResults(TournamentModel model)
        {
            int startingRound = model.CheckCurrentRound();
            List<MatchupModel> toScore = new List<MatchupModel>();

            foreach (List<MatchupModel> round in model.Rounds)
            {
                foreach (MatchupModel rm in round)
                {
                    if (rm.Winner == null && (rm.Entries.Any(x => x.Score != 0) || rm.Entries.Count == 1))
                    {
                        toScore.Add(rm);
                    }
                }
            }

            MarkWinnersInMatchups(toScore);

            AdvanceWinners(toScore, model);

            toScore.ForEach(x => GlobalConfig.Connection.UpdateMatchup(x));

            int endingRound = model.CheckCurrentRound();

            if (CheckIfTournamendEnded(model))
            {
                AlertUsersToWinner(model);
                PdfCreator.CreateBrackets($"{ model.TournamentName }_RESULTS", model);
                IDataConnection connection = GlobalConfig.Connection;
                connection.SetTournamentInavtive(model);
                throw new Exception("Winner is drafted!");
            }

            if (endingRound > startingRound)
            {
                // TODO in last match winner should be announced and tournament should end (delete?)
                model.AlertUsersToNewRound();
            }
        }

        private static bool CheckIfTournamendEnded(TournamentModel tournament)
        {
            bool isEnd = true;
            string winner = string.Empty;
            foreach (List<MatchupModel> round in tournament.Rounds)
            {
                foreach (MatchupModel rm in round)
                {
                    if (rm.Winner == null) { isEnd = false; return isEnd; }
                    winner = rm.Winner.TeamName;
                }
            }

            if (isEnd)
            { 
                Console.WriteLine($"End of tournament. Winner: { winner }");
            }

            return isEnd;
        }

        private static string CheckWinnerName(TournamentModel tournament)
        {
            string winner = string.Empty;
            List<MatchupModel> round = tournament.Rounds[tournament.Rounds.Count - 1];

            foreach (MatchupModel rm in round)
            {
                if (rm.Winner != null) { winner = rm.Winner.TeamName; }
            }
            
            return winner;
        }

        public static void AlertUsersToWinner(this TournamentModel model)
        {
            List<List<MatchupModel>> rounds = model.Rounds;

            string winner = CheckWinnerName(model);

            foreach (List<MatchupModel> round in rounds)
            {
                foreach (MatchupModel matchup in round)
                {
                    foreach (MatchupEntryModel me in matchup.Entries)
                    {
                        foreach (PersonModel p in me.TeamCompeting.TeamMembers)
                        {
                            AlertPersonAboutWinner(p, winner, matchup.Entries.Where(x => x.TeamCompeting != me.TeamCompeting).FirstOrDefault());
                        }
                    }
                } 
            }
        }

        public static void AlertUsersToNewRound(this TournamentModel model)
        {
            int currentRoundNumber = model.CheckCurrentRound();
            List<MatchupModel> currentRound = model.Rounds.Where(x => x.First().MatchupRound == currentRoundNumber).First();

            foreach (MatchupModel matchup in currentRound)
            {
                foreach (MatchupEntryModel me in matchup.Entries)
                {
                    if (me.TeamCompeting != null)
                    {
                        foreach (PersonModel p in me.TeamCompeting.TeamMembers)
                        {
                            AlertPersonToNewRound(p, me.TeamCompeting.TeamName, matchup.Entries.Where(x => x.TeamCompeting != me.TeamCompeting).FirstOrDefault());
                        }
                    }
                }
            }

        }

        private static void AlertPersonAboutWinner(PersonModel p, string winner, MatchupEntryModel competitor)
        {
            if (p.EmailAddress.Length == 0)
            {
                return;
            }

            string to = "";
            string subject = "";
            StringBuilder body = new StringBuilder();

            subject = "Tournament has ended!";

            body.AppendLine($"<h1>The winner is: { winner }!</h1><br>");
            body.AppendLine("Thank you for your participation!<br>");
            body.AppendLine("<br>");
            body.AppendLine("~Tournament Score Tracker");

            to = p.EmailAddress;

            EmailLogic.SendEmail(to, subject, body.ToString());
        }

        private static void AlertPersonToNewRound(PersonModel p, string teamName, MatchupEntryModel competitor)
        {
            if (p.EmailAddress.Length == 0)
            {
                return;
            }

            string to = "";
            string subject = "";
            StringBuilder body = new StringBuilder();

            if (competitor != null)
            {
                subject = $"You have a new matchup with {competitor.TeamCompeting.TeamName}";

                body.AppendLine("<h1>You have a new matchup</h1>");
                body.Append("<strong>Competitor: </strong>");
                body.Append(competitor.TeamCompeting.TeamName);
                body.AppendLine(".<br>");
                body.AppendLine("<br>");
                body.AppendLine("Have a great time!<br>");
                body.AppendLine("~Tournament Score Tracker");
            }
            else
            {
                subject = "You have a bye this round";

                body.AppendLine("Enjoy your round off<br>");
                body.AppendLine("~Tournament Score Tracker");
            }

            to = p.EmailAddress;

            EmailLogic.SendEmail(to, subject, body.ToString());
        }

        private static int CheckCurrentRound(this TournamentModel model)
        {
            int output = 1;

            foreach (List<MatchupModel> round in model.Rounds)
            {
                if (round.All(x => x.Winner != null))
                {
                    output += 1;
                }
            }

            return output;
        } 

        private static void AdvanceWinners(List<MatchupModel> models, TournamentModel tournament)
        {
            foreach (MatchupModel m in models)
            {
                foreach (List<MatchupModel> round in tournament.Rounds)
                {
                    foreach (MatchupModel rm in round)
                    {
                        foreach (MatchupEntryModel me in rm.Entries)
                        {
                            if (me.ParentMatchup != null)
                            {
                                if (me.ParentMatchup.Id == m.Id)
                                {
                                    me.TeamCompeting = m.Winner;
                                    GlobalConfig.Connection.UpdateMatchup(rm);
                                }
                            }
                        }
                    }
                }
            }
        }

        private static void MarkWinnersInMatchups(List<MatchupModel> models)
        {
            //greter or lesser
            string greaterWins = ConfigurationManager.AppSettings["greaterWins"];

            foreach (MatchupModel m in models)
            {
                //Checks for bye week entry
                if (m.Entries.Count == 1)
                {
                    m.Winner = m.Entries[0].TeamCompeting;
                    continue;
                }

                //0 means false, or low score wins
                if (greaterWins == "0")
                {
                    if (m.Entries[0].Score < m.Entries[1].Score)
                    {
                        m.Winner = m.Entries[0].TeamCompeting;
                    }
                    else if (m.Entries[1].Score < m.Entries[0].Score)
                    {
                        m.Winner = m.Entries[1].TeamCompeting;
                    }
                    else
                    {
                        throw new Exception("We do not allow ties in this applocation.");
                    }
                }
                else
                {
                    //1 mean true or high score wins
                    if (m.Entries[0].Score > m.Entries[1].Score)
                    {
                        m.Winner = m.Entries[0].TeamCompeting;
                    }
                    else if (m.Entries[1].Score > m.Entries[0].Score)
                    {
                        m.Winner = m.Entries[1].TeamCompeting;
                    }
                    else
                    {
                        throw new Exception("We do not allow ties in this applocation.");
                    }
                } 
            }

            //if (teamOneScore > teamTwoScore)
            //{
            //    //Team one wins
            //    m.Winner = m.Entries[0].TeamCompeting;
            //}
            //else if (teamOneScore < teamTwoScore)
            //{
            //    m.Winner = m.Entries[1].TeamCompeting;
            //}
            //else
            //{
            //    MessageBox.Show("Tie games aren't handled!");
            //}
        }

        private static void CreateOtherRounds(TournamentModel model, int rounds)
        {
            int round = 2;
            List<MatchupModel> previousRound = model.Rounds[0];
            List<MatchupModel> currRound = new List<MatchupModel>();
            MatchupModel currMatchup = new MatchupModel();

            while (round <= rounds)
            {
                foreach (MatchupModel match in previousRound)
                {
                    currMatchup.Entries.Add(new MatchupEntryModel { ParentMatchup = match });

                    if (currMatchup.Entries.Count > 1)
                    {
                        currMatchup.MatchupRound = round;
                        currRound.Add(currMatchup);
                        currMatchup = new MatchupModel();
                    }
                }

                model.Rounds.Add(currRound);
                previousRound = currRound;

                currRound = new List<MatchupModel>();
                round++;
            }
        }

        private static List<MatchupModel> CreateFirstRound(int byes, List<TeamModel> teams)
        {
            List<MatchupModel> output = new List<MatchupModel>();
            MatchupModel curr = new MatchupModel();

            foreach (TeamModel team in teams)
            {
                curr.Entries.Add(new MatchupEntryModel { TeamCompeting = team });

                if (byes > 0 || curr.Entries.Count > 1)
                {
                    curr.MatchupRound = 1;
                    output.Add(curr);
                    curr = new MatchupModel();

                    if (byes > 0)
                    {
                        byes--;
                    }
                }
            }

            return output;
        }

        private static int NumberOfByes(int rounds, int numberOfTeams)
        {
			int totalTeams = 1;

            for (int i = 1; i <= rounds; i++)
            {
                totalTeams *= 2;
            }

			int output = totalTeams - numberOfTeams;

			return output;
        }

        private static int FindNumberOfRounds(int teamCount)
        {
            int output = 1;

            int val = 2;

            while (val < teamCount)
            {
                output++;
                val *= 2;
            }

            return output;
        }

        private static List<TeamModel> RandomizeTeamOrder(List<TeamModel> teams)
        {
            return teams.OrderBy(t => Guid.NewGuid()).ToList();
        }

    }
}
