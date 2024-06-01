using System.ComponentModel.DataAnnotations;

namespace Bloggie.Models.Domain
{
    public class Loging
    {
        [Required]
        [StringLength(50)]
        public string Username { get; set; }
        [Required]
        [StringLength(50)]
        public string Password { get; set; }
    }
}
