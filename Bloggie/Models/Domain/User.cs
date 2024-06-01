using System.ComponentModel.DataAnnotations;

namespace Bloggie.Models.Domain
{
    public class User
    {
        [Key]
        public string UserId { get; set; }
        [Required]
        [StringLength(50)]
        public string Username { get; set; }
        [Required]
        [StringLength(50)]
        public string Password { get; set; }
        public string Email { get; set; }
        public string FullName { get; set; }
        public string AvatarUrl { get; set; } // Đường dẫn đến hình ảnh đại diện
        public DateTime CreatedAt { get; set; }
    }
}
