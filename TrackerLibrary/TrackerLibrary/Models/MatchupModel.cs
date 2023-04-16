using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TrackerLibrary.Model
{
    /// <summary>
    /// Represents one match in the tournament
    /// </summary>
    public class MatchupModel
    {
        /// <summary>
        /// The unique identifier for the Matchup.
        /// </summary>
        public int Id { get; set; }
        /// <summary>
        /// Represents teams that have match against each other.
        /// </summary>
        public List<MatchupEntryModel> Entries { get; set; } = new List<MatchupEntryModel>();
        /// <summary>
        /// The ID from the database that will be used to identify the winner.
        /// </summary>
        public int WinnerId { get; set; }
        /// <summary>
        /// Represents team that won the match.
        /// </summary>
        public TeamModel Winner { get; set; }
        /// <summary>
        /// Represents number of round in which match was taking place.
        /// </summary>
        public int MatchupRound { get; set; }

        public string DisplayName 
        { 
            get
            {
                string output = string.Empty;

                foreach (MatchupEntryModel me in Entries)
                {
                    if (me.TeamCompeting != null)
                    {
                        if (output.Length == 0)
                        {
                            output = me.TeamCompeting.TeamName;
                        }
                        else
                        {
                            output += $" vs. {me.TeamCompeting.TeamName}";
                        } 
                    }
                    else
                    {
                        output = "Matchup not yet determined";
                        break;
                    }
                }

                return output;
            }
        }
    }
}
