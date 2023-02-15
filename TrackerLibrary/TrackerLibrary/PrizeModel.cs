using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TrackerLibrary
{
    public class PrizeModel
    {
        /// <summary>
        /// Represents number of place.
        /// </summary>
        public int PlaceNumber { get; set; }
        /// <summary>
        /// Represents name of place.
        /// 
        /// </summary>
        /// <example>
        /// "The champions"
        /// </example>
        public string PlaceName { get; set; }
        /// <summary>
        /// Represents value in currency of prize.
        /// </summary>
        public decimal PrizeAmount { get; set; }
        /// <summary>
        /// Represents percentage of prize.
        /// </summary>
        public double PrizePercentage { get; set; }

    }
}
