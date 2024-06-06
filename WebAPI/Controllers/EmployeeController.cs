using ApplicationLayer.Contracts;
using DomainLayer.Entities;
using Microsoft.AspNetCore.Mvc;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace WebAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EmployeeController : ControllerBase
    {
        private readonly IEmployee employee;

        public EmployeeController(IEmployee employee)
        {
            this.employee = employee;
        }

        // GET: api/<EmployeeController>
        [HttpGet]
        public async Task<IActionResult> Get()
        {
            var data = await employee.GetAsync();
            return Ok(data);
        }

        // GET api/<EmployeeController>/5
        [HttpGet("{id}")]
        public async Task<IActionResult> GetById(int id)
        {
            var data = await employee.GetByIdAsync(id);
            return Ok(data);
        }

        // POST api/<EmployeeController>
        [HttpPost]
        public async Task<IActionResult> Add([FromBody] Employee employeeDto)
        {
            var resuft = await employee.AddAsync(employeeDto);
            return Ok(resuft);
        }

        // PUT api/<EmployeeController>/5
        [HttpPut]
        public async Task<IActionResult> Update([FromBody] Employee employeeDto)
        {
            var resuft = await employee.UpadteAsync(employeeDto);
            return Ok(resuft);
        }

        // DELETE api/<EmployeeController>/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            var data = await employee.DeleteAsync(id);
            return Ok(data);
        }
    }
}
