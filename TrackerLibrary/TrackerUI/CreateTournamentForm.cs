using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using TrackerLibrary;
using TrackerLibrary.Model;

namespace TrackerUI
{
    public partial class CreateTournamentForm : Form, IPrizeRequester, ITeamRequester
    {
		readonly List<TeamModel> availableTeams = GlobalConfig.Connection.GetTeam_All();
		readonly List<TeamModel> selectedTeams = new List<TeamModel>();
		readonly List<PrizeModel> selectedPrizes = new List<PrizeModel>();
        
        public CreateTournamentForm()
        {
            InitializeComponent();

            WireUpList();
        }

        private void WireUpList()
        {
            selectTeamDropBox.DataSource = null;

            selectTeamDropBox.DataSource = availableTeams;
            selectTeamDropBox.DisplayMember = "TeamName";

            tournamentTeamsListBox.DataSource = null;

            tournamentTeamsListBox.DataSource = selectedTeams;
            tournamentTeamsListBox.DisplayMember = "TeamName";

            prizesListBox.DataSource = null;

            prizesListBox.DataSource = selectedPrizes;
            prizesListBox.DisplayMember = "PrizePlaceAndNumber";
        }

        private void addTeamButton_Click(object sender, EventArgs e)
        {
            TeamModel t = (TeamModel)selectTeamDropBox.SelectedItem;

            if (t != null)
            {
                availableTeams.Remove(t);
                selectedTeams.Add(t);

                WireUpList();
            }
        }

        private void createPrizeButton_Click(object sender, EventArgs e)
        {
            // call the createPrizeForm
            CreatePrizeForm frm = new CreatePrizeForm(this);
            frm.Show();
        }

        private void createNewTeamLink_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            CreateTeamForm frm = new CreateTeamForm(this);
            frm.Show();
        }

        public void PrizeComplete(PrizeModel model)
        {
            // Get back from the form PrizeModel
            // Take that PrizeModel into list of selected Prizes
            selectedPrizes.Add(model);
            WireUpList();
        }

        public void TeamComplete(TeamModel model)
        {
            selectedTeams.Add(model);
            WireUpList();
        }

        private void removeSelectedPlayerButton_Click(object sender, EventArgs e)
        {
            TeamModel t = (TeamModel)tournamentTeamsListBox.SelectedItem;

            if (t != null)
            {
                selectedTeams.Remove(t);
                availableTeams.Add(t);

                WireUpList();
            }
        }

        private void removeSelectedPrizeButton_Click(object sender, EventArgs e)
        {
            PrizeModel p = (PrizeModel)prizesListBox.SelectedItem;

            if (p != null)
            {
                selectedPrizes.Remove(p);

                WireUpList();
            }
        }

        private void createTournamentButton_Click(object sender, EventArgs e)
        {
            // validate data
            decimal fee = 0;

            bool feeAcceptable = decimal.TryParse(entryFeeValue.Text, out fee);

            if (!feeAcceptable)
            {
                MessageBox.Show("You need to ented a valid Entry Fee.", 
                    "Invalid Fee", 
                    MessageBoxButtons.OK, 
                    MessageBoxIcon.Error);
                return;
            }

			// create tournament model
			TournamentModel tm = new TournamentModel
			{
				TournamentName = tournamentNameValue.Text,
				EntryFee = fee,

				Prizes = selectedPrizes,
				EnteredTeams = selectedTeams
			};

			// Wire matchups
			TournamentLogic.CreateRounds(tm);

            // create tournaments entry
            // create all of the prizes entries
            // create all of team entries

            GlobalConfig.Connection.CreateTournament(tm);

            TournamentViewerForm frm = new TournamentViewerForm(tm);
            frm.Show();
            this.Close();
        }
    }
}
