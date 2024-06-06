using DomainLayer.Entities;
using Microsoft.EntityFrameworkCore;
namespace InfrastructureLayer.Data;

public class AppDbContext : DbContext
{
    public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
    {
    }

    public DbSet<Employee> Employees { get; set; }

    //Fluent API
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        modelBuilder.Entity<Employee>(entity =>
        {
            entity.HasKey(e => e.Id); // Cấu hình khóa chính

            entity.Property(e => e.Id)
                .ValueGeneratedOnAdd(); // Khóa chính tự tăng

            entity.Property(e => e.Name)
                .IsRequired() // Cấu hình kiểu dữ liệu
                .HasMaxLength(100); // Cấu hình kích thước

            entity.Property(e => e.Address)
                .HasMaxLength(200); // Cấu hình kích thước cho thuộc tính Address
        });
    }
}
