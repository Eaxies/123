# 第04章_运算符
# 1.算术运算符: + - * /(div) %(mod)
 SELECT 100, 100 + 0, 100 - 0, 100 + 50, 100 + 50 -30, 100 + 35.5, 100 - 35.5 
 FROM DUAL;
                     
# 在SQL中,+没有连接的作用,就表示加法运算.此时,会将字符串转变为数值(隐式转换)                      
SELECT 100 + '1'     # 在java中,结果是: 1001. 
FROM DUAL;
 
SELECT 100 + 'a'     # 此时讲'a'看作0处理
FROM DUAL;

SELECT 100 + NULL    # NULL值参与运算,结果就为NULL
FROM DUAL;

SELECT 100, 100 * 1, 100 * 1.0, 100 / 1.0, 100 / 2,
100 + 2 * 5 / 2,100 / 3, 100 DIV 0                 # 分母如果为0,则结果为NULL
FROM DUAL;

# 取模运算: % mod
SELECT 12 % 3,12 % 5,12 MOD -5, -12 % 5,-12 % -5
FROM DUAL;    # 第一个正负决定结果的正负

#练习: 查询员工id为偶数的员工信息
SELECT * 
FROM employees
WHERE
employee_id % 2 = 0;

#2.比较运算符 

#比较的结果为真则返回1，比较的结果为假则返回0，其他情况则返回NULL。

#2.1 =  <=> <> != < <= > >=

SELECT 1 = 2, 1!=2,1='1',1='a',0='a'  # 字符串不能转化为数值类型,则看作为0(隐式转换失败)
FROM DUAL;
 
SELECT 'a' = 'a','ab'='ab','a'='b' # 两边纯粹字符串之间比较不存在隐式转换,按照ANSI的比较规则进行比较
FROM DUAL;

SELECT 1= NULL,NULL=NULL # 只要有null参与比较,结果就为NULL
FROM DUAL;

SELECT employee_id,salary,commission_pct
FROM employees
#where salary = 6000;
WHERE commission_pct = NULL; #此时执行, 不会有任何的结果

# <=> "为NULL而生"
SELECT 1 <=> 2,1<=>'1',1<=> 'a',0<=>'a'  
FROM DUAL;

SELECT 1=NULL, 1<=> NULL,NULL=NULL,NULL<=>NULL
FROM DUAL;

#练习: 查询表中commission_pct为NULL的数据有哪些
SELECT employee_id,salary,commission_pct
FROM employees
WHERE commission_pct <=> NULL;

SELECT 3<>2,'4'<> NULL,''!=NULL,NULL != NULL
FROM DUAL;

#2.2
# ①IS NULL \ IS NOT NULL \ ISNULL
#练习:查询表中commission_pct为NULL的数据有哪些
SELECT employee_id,salary,commission_pct
FROM employees
WHERE commission_pct IS NULL;
#或
SELECT employee_id,salary,commission_pct
FROM employees
WHERE commission_pct IS NULL;

#练习:查询表中commission_pct不为NULL的数据有哪些
SELECT employee_id,salary,commission_pct
FROM employees
WHERE commission_pct IS NOT NULL; 
#或
SELECT employee_id,salary,commission_pct
FROM employees
WHERE NOT commission_pct <=> NULL;


# ② LEAST() \ GREATEST
 
SELECT LEAST('g','b','t','m'),GREATEST('g','b','t','m')
FROM DUAL;

SELECT LEAST(first_name,last_name)
FROM employees;

SELECT LEAST(first_name,last_name),LEAST(LENGTH(first_name),LENGTH(last_name))
FROM employees;

# ③ BETWEEN ... AND ... (包含边界)  
# 查询工资在6000到8000的员工信息
SELECT employee_id,salary
FROM employees
#where salary BETWEEN 6000 AND 8000;
WHERE salary  >=6000 && salary <=8000;

#交换6000和8000之后,查询不到数据
SELECT employee_id,salary
FROM employees
WHERE salary BETWEEN 6000 AND 8000;

# 查询工资不在6000到8000的员工信息
SELECT employee_id,salary
FROM employees
WHERE salary <6000 OR salary>8000;
#WHERE salary NOT BETWEEN 6000 AND 8000;
#where salary <>6000 and salary <>8000; #错误的,结果会出现两次

# ④ in(set) \ not in(set)

#练习: 查询部门为10,20,30部门的员工信息
SELECT employee_id, last_name, department_id
FROM employees
#where department_id =10 or department_id =20 or department_id =30
WHERE department_id IN(10,20,30);

#练习: 查询工资不是6000,7000,8000的员工信息
SELECT employee_id,last_name,salary
FROM employees
WHERE salary NOT IN(6000,7000,8000)

# ⑤ LIKE 模糊查询
# %: 代表不确定个数的字符( 0个, 1个, 或多个)

#练习: 查询last_name中包含字符'a'的员工信息
SELECT last_name
FROM employees
WHERE last_name LIKE '%a%';

#练习: 查询last_name中以字符'a'开头的员工信息
SELECT last_name
FROM employees
WHERE last_name LIKE 'a%';

#练习: 查询last_name中包含字符'a'且包含字符'e'的员工信息
SELECT last_name
FROM employees
WHERE last_name LIKE '%a%' AND last_name LIKE '%e%';

SELECT last_name
FROM employees
WHERE last_name LIKE '%a%e%' OR last_name LIKE '%e%a%';

# _ :代表一个不确定的字符 

#练习: 查询last_name中第二个字符是'a'的员工信息
SELECT last_name
FROM employees
WHERE last_name LIKE '_a%';

#练习: 查询第2个字符是_且第3个字符是'a'的员工信息
#需要使用转义字符:\
SELECT last_name
FROM employees
WHERE last_name LIKE '_\_a%';

#或者

SELECT last_name
FROM employees
WHERE last_name LIKE '_$_a%'ESCAPE'$'; 

# ⑥ REGEXP RLIKE : 正则表达式
SELECT 'shkstart' REGEXP '^s', 'shkstart' REGEXP 't$', 'shkstart' REGEXP 'hk'
FROM DUAL;

SELECT 'atguigudb' REGEXP 'gu.gu','atguigudb' REGEXP '[ab]'
FROM DUAL;

# 3. 逻辑运算符: OR II  \  AND &&  \   NOT  !NOT
# OR 与 AND 可以一起使用, AND优先级更高
# XOR  异或
SELECT last_name,salary,department_id
FROM employees
WHERE department_id=50 XOR salary > 6000; #只满足两个条件中的一个条件

# 4.位运算符: &  |  ^  ~  >>  << 

SELECT 12 & 5, 12 | 5,12 ^ 5 
FROM DUAL;
