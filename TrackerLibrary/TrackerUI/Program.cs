using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;
using TrackerLibrary;

namespace TrackerUI
{
    internal static class Program
    {
        /// <summary>
        /// Główny punkt wejścia dla aplikacji.
        /// </summary>
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);

            // Initialize the Database Connections
            TrackerLibrary.GlobalConfig.InitializeConnections(DatabaseType.Sql);

            Application.Run(new CreateTournamentForm());

            //Application.Run(new TournamentDashboardForm());
        }
    }
}
