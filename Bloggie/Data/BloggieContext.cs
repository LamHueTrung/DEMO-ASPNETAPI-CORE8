using Bloggie.Models.Domain;
using Microsoft.EntityFrameworkCore;
using System.Reflection.Emit;
using Microsoft.EntityFrameworkCore;
using System.Linq;
namespace Bloggie.Data
{
    public class BloggieContext :DbContext
    {
        public BloggieContext(DbContextOptions<BloggieContext> options)
        : base(options)
        {
        }
        public DbSet<Post> Posts { get; set; }
        public DbSet<Comment> Comments { get; set; }
        public DbSet<Tag> Tags { get; set; }
        public DbSet<User> Users { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<User>(modelBuilder =>
            {
                modelBuilder.HasIndex(e => e.Username).IsUnique();
                modelBuilder.Property(e => e.Password).IsRequired().HasMaxLength(50);
                modelBuilder.Property(e => e.Email).IsRequired().HasMaxLength(150);
                modelBuilder.Property(e => e.FullName).IsRequired().HasMaxLength(50);

            });
        }
    }
}
