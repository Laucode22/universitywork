# universitywork
With the arrival of vaccines for COVID-19. 
We create and classified a vaccination strategy that takes into account not only the order of arrival of patients to the vaccination center, 
but also their membership of (priority groups).  
The main reason for ordering a vaccination is to consider the priority of each patient first. 
For example: (patients with a higher priority will be attended first) and patients with the same priority, will choose the ones who arrived earlier.  
The abstract data structure that corresponds to this situation is the priority queue: A modified queue in which, instead of exiting items in the order they came in,
first the highest priority will come out (ordered in the order of arrival).  
In this practice we will consider two alternative implementations for a priority queue: The first, called a bucket queue, 
uses a sequential data structure to store the different priority levels.  The second, is to store the priority levels using a binary search tree.   
Once both options are implemented, we will apply them to two different cases, and we will do a comparative study of the efficiency of both implementations 
in each one of the cases.

The code is in universitywork/src/es/uned/lsi/eped/pract2020_2021/
