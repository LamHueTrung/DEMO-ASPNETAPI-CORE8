namespace Bloggie.Models.ViewModels
{
    public class AddUserRequest
    {
        public string Username { get; set; }
        public string Password { get; set; }
        public string Email { get; set; }
        public string FullName { get; set; }
        public IFormFile Avatar { get; set; }
    }
}
