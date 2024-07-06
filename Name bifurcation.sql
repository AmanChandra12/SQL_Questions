use ytvideos
Drop table customers
CREATE TABLE customers (
    customer_id INT,
    customer_name VARCHAR(255)
);

INSERT INTO customers (customer_id, customer_name) VALUES
(2, 'Yadhagiri Gady'),
(3, 'Vamshi Pratap Singh'),
(1, 'Rohit'),
(4, 'Ananya Sharma'),
(5, 'Ravi Kumar Patil'),
(12, 'Rajesh Sneha Nair Kapoor');

with cte as(
select *,LEN(customer_name)-len(REPLACE(customer_name,' ','')) as ts,
CHARINDEX(' ',customer_name) as eofn,
CHARINDEX(' ' ,customer_name,CHARINDEX(' ',customer_name)+1) as eosn
from customers
)

select case when ts = 0 then customer_name 
		else SUBSTRING(customer_name,1,eofn) end as first_name,
			case when ts = 2 then  SUBSTRING(customer_name,eofn+1,eosn-eofn) end as middle_name,
				case when ts = 1 then SUBSTRING(customer_name,eofn+1,len(REPLACE(customer_name,' ',''))) 
					when ts =2 then SUBSTRING(customer_name,eosn+1,len(REPLACE(customer_name,' ',''))) end as last_name

from cte
