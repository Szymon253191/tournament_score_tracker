﻿using System;
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
        /// Represents team that won the match.
        /// </summary>
        public TeamModel Winner { get; set; }
        /// <summary>
        /// Represents number of round in witch match was taking place.
        /// </summary>
        public int MatchupRound { get; set; }
    }
}
