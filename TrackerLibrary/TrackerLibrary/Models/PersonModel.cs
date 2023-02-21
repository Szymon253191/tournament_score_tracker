﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TrackerLibrary.Model
{
    public class PersonModel
    {
        /// <summary>
        /// The unique identifier for the prize.
        /// </summary>
        public int Id { get; set; }
        /// <summary>
        /// Represents first name of player.
        /// </summary>
        public string FirstName { get; set; }
        /// <summary>
        /// Represents last name of player.
        /// </summary>
        public string LastName { get; set; }
        /// <summary>
        /// Represents e-mail address of player.
        /// </summary>
        public string EmailAddress { get; set; }
        /// <summary>
        /// Represents phone number of player.
        /// </summary>
        public string PhoneNumber { get; set; }
    }
}
