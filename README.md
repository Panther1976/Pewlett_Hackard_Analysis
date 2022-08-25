# Employee Database Challenge Overview – The “Silver Tsunami”
The purpose of this analysis is to gather data for a potential “Silver Tsunami” about to hit Pewlett Hackard. The “Silver Tsunami” refers to the large number of employees approaching retirement age and in turn may be retiring at the same time. By having a clear idea of the number of potential retirees and their departments, Pewlett Hackard can prepare by creating a mentorship program where retirees can train the next generation of employees. 

## Results

To determine the number of potential retirees, we created a table called retirement_titles. This table provided a list of employees that were still with the company and were born between January 1, 1952 and December 31, 1955. The results are as follows:

### Unique Titles Table
![unique_titles_table_m](https://user-images.githubusercontent.com/106631875/186563697-610b38fd-9316-4afb-8a99-d0685ca4afbe.png)

-	There are 72,458 potential retirees according to the retirement_titles table which is based on birth dates between January 1, 1952 to December 31, 1955
-	Senior Engineers make up the largest number of potential retirees at 25,916
-	Senior Staff make are a close second at 24,926 potential retirees
-	Managers make up the fewest potential retirees at 2

## Summary

-	How many roles will need to be filled as the "Silver Tsunami" begins to make an impact?

Based on our analysis there are 72,458 employees that meet the criteria for retirement. There are an additional 1,549 employees that are eligible for the mentorship program which could impact their normal day-to-day roles.

-	Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?

With over 72,000 roles to potentially fill and only 1549 employees that are eligible for the mentorship program, there is clearly not enough employees to fill the potential gap in the workforce. There are plenty of qualified potential retirees to help train and mentor but just not enough employees to be mentored, based on this criteria, to fill the positions that may be coming available. 

However, the analysis has some limitations. The biggest of which is that it is basing the potential “Silver Tsunami” on retirement age and not on intention which could drastically impact the timeline and size of the so-called Tsunami. The analysis also does not address whether there is a need to replace 100% of the potentially retiring employees. If there is still a strong need for these roles, perhaps incentives, raises or the creation of new roles can alleviate some of the pressure from a “Silver Tsunami” (massive retirement). The analysis is also limiting the eligibility of the employees for the mentorship on age as well instead of qualifications of existing employees or potential new hires. 

We created 2 additional tables and ran queries based off those to further illustrate the potential shortcoming if/when the Silver Tsunami hits Pewlett Hackard. Below is a look at the 1549 employees that are eligible for the mentorship program and which roles they hold. 

### Mentorship by Title
![mentorship_by_title_m](https://user-images.githubusercontent.com/106631875/186563901-70c9c382-bd16-4524-94f1-b9c0f2198032.png)

By comparing this with the unique_titles table above, we can see just how short Pewlett Hackard is in trying to fill the potential vacancies. Those eligible for the mentorship make up a total of 2.14% of the total vacancies that may need to be filled. They are broken down by title as follows:

  - Eligible Staff employees at 424 only make up 5.5% that need to be filled
  - Eligible Senior Engineers at 395 only make up 1.5% that need to be filled
  - Eligible Engineers at 309 only make up 3.3% that need to be filled
  - Eligible Senior Staff at 300 only make up 1.2% that need to be filled
  - Eligible Technique Leaders only make up 2.1% that need to be filled
  - Eligible Assistant Engineers only make up 4% that need to be filled
  - There were none eligible for the Manager role

Below breaks down the employees eligible for the mentorship by department:

### Mentorship by Department
![mentorship_by_department_m](https://user-images.githubusercontent.com/106631875/186563986-0ae8d21f-038f-4af4-945d-43735f489bf3.png)

To shed further light on which departments would be impacted the most, another query that could shed further light would be to look at the make up of those eligible for retirement by department.
