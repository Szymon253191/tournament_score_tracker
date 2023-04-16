﻿using System;
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
    public partial class TournamentDashboardForm : Form
    {

        readonly List<TournamentModel> tournament = GlobalConfig.Connection.GetTournament_Active();

        public TournamentDashboardForm()
        {
            InitializeComponent();

            WireUpLists();
        }

        private void WireUpLists()
        {
            loadExistingTournamentDropBox.DataSource = tournament;
            loadExistingTournamentDropBox.DisplayMember = "TournamentName";
        }

        private void createTournamentButton_Click(object sender, EventArgs e)
        {
            CreateTournamentForm frm = new CreateTournamentForm();
            frm.Show();
        }

        private void loadTournamentButton_Click(object sender, EventArgs e)
        {
            TournamentModel tm = (TournamentModel) loadExistingTournamentDropBox.SelectedItem;
            TournamentViewerForm frm = new TournamentViewerForm(tm);
            frm.Show();
        }
    }
}
