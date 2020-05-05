using System;
using System.Linq;
using System.Collections.Generic;

namespace LinqExample
{
    class Program
    {
        static void Main(string[] args)
        {

            IList<Employee> emplist = new List<Employee>()
            {
                new Employee(){EmpId = 1, FirstName= "John",LastName="Abraham",salary=1000000,JoinDate="01-JAN-13 12.00.00 AM",Department="Banking"},
                new Employee(){EmpId = 2, FirstName= "Michael",LastName="Clarke",salary=800000,JoinDate="01-JAN-13 12.00.00 AM",Department="Insurance"},
                new Employee(){EmpId = 3, FirstName= "Roy",LastName="Thomas",salary=700000,JoinDate="01-FEB-13 12.00.00 AM",Department="Banking"},
                new Employee(){EmpId = 4, FirstName= "Tom",LastName="Jose",salary=600000,JoinDate="01-FEB-13 12.00.00 AM",Department="Insurance"},
                new Employee(){EmpId = 5, FirstName= "Jerry",LastName="Pinto",salary=650000,JoinDate="01-FEB-13 12.00.00 AM",Department="Insurance"},
                new Employee(){EmpId = 6, FirstName= "Philip",LastName="Mathew",salary=750000,JoinDate="01-JAN-13 12.00.00 AM",Department="Services"},
                new Employee(){EmpId = 7, FirstName= "TestName1",LastName="123",salary=650000,JoinDate="01-JAN-13 12.00.00 AM",Department="Services"},
                new Employee(){EmpId = 8, FirstName= "TestName2",LastName="Lname",salary=600000,JoinDate="01-FEB-13 12.00.00 AM",Department="Insurance"},
            };

            // 2.Get all employee details from the employee table
            var result = from e in emplist
                         select e;
            foreach (var empr in result)
            {
                Console.WriteLine("EmpId:{0},FirstName:{1},LastName:{2},Salary{3},JoinDate{4}"
                    , empr.EmpId, empr.FirstName, empr.LastName, empr.salary, empr.JoinDate);
            }

            //3.Get First_Name, Last_Name from employee table
            var result = from e in emplist
                         select e;
            foreach (var empr in result)
            {
                Console.WriteLine("FirstName:{0},LastName:{1}", empr.FirstName, empr.LastName);
            }

            //5.Get First_Name from employee table in upper case
            var result = from e in emplist
                         select e;
            foreach (var empr in result)
            {
                Console.WriteLine("FirstName:{0}", empr.FirstName.ToUpper());
            }

            //6.Get First_Name from employee table in lower case
            var result = from e in emplist
                         select e;
            foreach (var empr in result)
            {
                Console.WriteLine("FirstName:{0}", empr.FirstName.ToLower());
            }

            //7.Get unique DEPARTMENT from employee table
            var result = (from e in emplist
                          select e.Department).Distinct();
            foreach (var empr in result)
            {
                Console.WriteLine("Department:{0}", empr);
            }

            //8.Select first 3 characters of FIRST_NAME from EMPLOYEE.
            var result = from e in emplist
                         select e.FirstName;
            foreach (var empr in result)
            {
                Console.WriteLine(empr.Substring(0, 3));

            }

            // 9.Get position of 'o' in name 'John' from employee table
            var result = from e in emplist
                         where e.FirstName == "John"
                         select e;
            foreach (var empr in result)
            {
                Console.WriteLine(empr.FirstName.IndexOf("o"));

            }
            
            // 12.Get length of FIRST_NAME from employee table
            var result = from e in emplist
                         select e.FirstName;
            foreach (var empr in result)
            {
                Console.WriteLine(empr.Length);

            }

            //13.Get First_Name from employee table after replacing 'o' with '$'
            var result = from e in emplist
                         select e;
            foreach (var empr in result)
            {
                Console.WriteLine(empr.FirstName.Replace("o", "$"));

            }

            // 16.Get all employee details from the employee table order by First_Name Ascending
            var orderbyResult = from e in emplist
                                orderby e.FirstName ascending
                                select e;
            Console.WriteLine("Ascending Order:");

            foreach (var empr in orderbyResult)
                Console.WriteLine(empr.FirstName);

            //17.Get all employee details from the employee table order by First_Name descending
            var orderbydescendingResult = from e in emplist
                                          orderby e.FirstName descending
                                          select e;
            Console.WriteLine("Descending Order:");

            foreach (var empr in orderbydescendingResult)
                Console.WriteLine(empr.FirstName);

            //19.Get employee details from employee table whose employee name is “John”
            var result = from e in emplist
                         where e.FirstName == "John"
                         select e;
            foreach (var empr in result)
            {
                Console.WriteLine("Fname:{0},Lame:{1},Date:{2}"
                    , empr.FirstName, empr.LastName, empr.JoinDate);
            }

            // 20.Get employee details from employee table whose employee name are “John” and “Roy”
            var result = from e in emplist
                         where e.FirstName == "John" || e.FirstName == "Roy"
                         select e;
            foreach (var empr in result)
            {
                Console.WriteLine("Fname:{0},Lame:{1},Date:{2}"
                    , empr.FirstName, empr.LastName, empr.JoinDate);
            }

            //22.Get employee details from employee table whose first name starts with 'J'
            var result = (from c in emplist
                          where c.FirstName.StartsWith("J")
                          select c);
            foreach (var empr in result)
            {
                Console.WriteLine("Fname:{0}"
                    , empr.FirstName);
            }

            // 23.Get employee details from employee table whose first name contains 'o'
            var result = (from c in emplist
                          where c.FirstName.Contains("o")
                          select c);
            foreach (var empr in result)
            {
                Console.WriteLine("Fname:{0}"
                    , empr.FirstName);
            }

            // 24.Get employee details from employee table whose first name ends with 'n'
            var result = (from c in emplist
                          where c.FirstName.EndsWith("n")
                          select c);
            foreach (var empr in result)
            {
                Console.WriteLine("Fname:{0}"
                    , empr.FirstName);
            }

            //27.Get employee details from employee table whose Salary greater than 600000
            var result = (from c in emplist
                          where c.salary > 600000
                          select c);
            foreach (var empr in result)
            {
                Console.WriteLine("FirstName{0},Salary{1}"
                    , empr.FirstName, empr.salary);
            }

            // 28.Get employee details from employee table whose Salary less than 800000
            var result = (from c in emplist
                          where c.salary < 800000
                          select c);
            foreach (var empr in result)
            {
                Console.WriteLine("FirstName{0},Salary{1}"
                    , empr.FirstName, empr.salary);
            }

        }
    }
}
