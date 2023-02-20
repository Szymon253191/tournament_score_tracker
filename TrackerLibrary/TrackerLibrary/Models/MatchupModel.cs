using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TrackerLibrary.Model
{
    public class MatchupModel
    {
        /// <summary>
        /// Represents teams that have match against each other.
        /// </summary>
        public List<MatchupEntryModel> Entries { get; set; } = new List<MatchupEntryModel>();
        /// <summary>
        /// Represents team that won the match.
        /// </summary>
        public TeamModel Winner { get; set; }
        /// <summary>
        /// Represents number of round in witch match was taking place.
        /// </summary>
        public int MatchupRound { get; set; }
    }
}
