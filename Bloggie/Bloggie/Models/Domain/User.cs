namespace Bloggie.Models.Domain
{
    public class User
    {
        public string UserId { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public string Email { get; set; }
        public string FullName { get; set; }
        public string AvatarUrl { get; set; } // Đường dẫn đến hình ảnh đại diện
        public DateTime CreatedAt { get; set; }
    }
}
