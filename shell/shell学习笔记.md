# shell学习笔记

## 常用指令

### 1、awk

#### 前言

awk 是一个强大的文本分析工具，它可以在 Linux 或 Unix 系统下对文本文件进行处理。它可以读取文件，对文件的每一行进行处理，然后按照指定格式输出。常用的用途包括文本过滤和数据提取等。

awk 的命令格式为：`awk 'pattern {action}' file`

其中，pattern 是一个正则表达式，用于匹配文件的行；action 是一组处理命令，用于对匹配的行进行处理。

#### 使用说明

1. -F: 指定输入分隔符。使用-F参数可以指定awk在读取文本文件时使用的字段分隔符。例如，如果我们想要使用逗号分隔符，则可以使用-F参数如下：

```bash
awk -F, '{print $1, $2}' file.txt
```

这将输出file.txt文件中的第一和第二个字段，并将它们用空格分隔开。

2. -v: 定义变量。使用-v参数可以在awk命令中定义一个变量。例如，如果我们想要定义一个名为"threshold"的变量，并将其设置为100，则可以使用-v参数如下：

```bash
awk -v threshold=100 '{if ($1 > threshold) print $0}' file.txt
```

这将输出file.txt文件中第一列大于100的行。

3. -f: 从文件中读取awk脚本。使用-f参数可以从指定的文件中读取awk脚本。例如，如果我们有一个名为"script.awk"的文件，并且想要使用它来处理"file.txt"文件，则可以使用-f参数如下：

```bash
awk -f script.awk file.txt
```

4. BEGIN和END模式：用于在awk处理文本之前和之后执行一些操作。BEGIN模式用于在awk开始处理文本之前执行一些操作，例如初始化变量。END模式用于在awk处理文本之后执行一些操作，例如打印总结信息。例如，我们可以使用BEGIN和END模式来计算file.txt文件中所有数字的总和并打印出来：

```bash
awk 'BEGIN {sum=0} {sum+=$1} END {print "Total:", sum}' file.txt
```

5. 模式匹配：awk的强大之处之一就是它支持使用正则表达式进行模式匹配。例如，如果我们想要查找包含"error"关键字的行并输出它们，则可以使用模式匹配如下：

```bash
awk '/error/ {print $0}' file.txt
```

这将输出file.txt文件中包含"error"关键字的所有行。

### 使用案例

#### 分割取值

假设有一个文本文件 file.txt，内容如下：

```text
1,John,Smith,34
2,Jane,Doe,28
3,Bob,Johnson,45
```

我们可以使用 awk 命令来对这个文件进行处理。例如，我们可以使用以下命令来输出第 1 列和第 3 列：

```bash
awk -F ',' '{print $1, $3}' file.txt
```

其中，`-F` 参数指定了分隔符为逗号，`{print $1, $3}` 指定了要输出第 1 列和第 3 列。输出结果如下：

```bash
1 Smith
2 Doe
3 Johnson
```

#### 计算总和

另一个例子是计算文件中数字列的总和。假设文件 file.txt 中有以下内容：

```text
1,John,Smith,34
2,Jane,Doe,28
3,Bob,Johnson,45
```

我们可以使用以下命令来计算第 4 列数字的总和：

```BASH
awk -F ',' '{sum += $4} END {print "Sum = ", sum}' file.txt
```

其中，`sum += $4` 表示累加第 4 列数字到变量 sum 中，`END` 表示在处理完所有行之后执行动作，`{print "Sum = ", sum}` 表示输出变量 sum 的值。输出结果如下：

```txt
Sum = 107
```

这只是 awk 的一些基本用法，awk 支持的功能非常丰富，可以用于更加复杂的文本处理任务。

#### 取值排序

假设有一个名为 `test.txt` 的文件，文件内容如下：

```text
Tom 80 90
Jerry 85 95
Lucy 90 88
```

现在我们需要对这个文件进行处理，求出每个人的平均成绩，并按照平均成绩从高到低排序，输出格式为姓名、平均成绩。

我们可以使用 awk 命令来完成这个任务，具体操作如下：

```bash
awk '{print $1,($2+$3)/2}' test.txt | sort -k2 -rn
```

上述命令中，`awk` 命令的操作是，对于每行数据，打印出第一列和第二列与第三列平均值，即姓名和平均成绩。`sort` 命令则按照第二列进行倒序排序，最后输出排序后的结果，即每个人的姓名和平均成绩。

运行上述命令后，输出结果如下：

```text
Jerry 90
Lucy 89
Tom 85
```

从输出结果可以看出，Jerry 的平均成绩最高，Tom 的平均成绩最低。

### 高级用法

awk是一种功能强大的文本处理工具，除了常规的文本处理外，它还有许多高级用法。

以下是一些awk的高级用法：

#### 进行数学计算

awk支持数学计算，可以用来执行一些基本的数学运算。例如，下面的命令可以将输入的数字相加并输出结果：

```bash
echo "1 2 3 4 5" | awk '{s=0; for(i=1;i<=NF;i++) s+=$i; print s}'
```

输出结果为15，即1+2+3+4+5。

#### 扩展

假设有一个文本文件 test.txt，内容如下：

```text
apple 1
banana 2
orange 3
```

可以使用以下命令，对其中的数字列进行求和：

```text
awk '{sum+=$2} END {print sum}' test.txt
```

输出结果为：

```text
6
```

这个命令的含义是，对于 test.txt 文件中的每一行，将第二列的数字加起来，并将结果保存在 sum 变量中。在文件处理完成后，通过 `END` 模块输出 sum 的值。

### 使用正则表达式

awk支持使用正则表达式来匹配和处理文本。下面的例子将匹配以字母"a"开头的单词并输出它们的数量：

```text
echo "apple banana abc orange pear able" | awk '{for(i=1;i<=NF;i++) if ($i ~ /^a/) count++} END {print count}'
```

输出结果为3，因为只有"apple"是以"a"开头的。

### 使用模式匹配

awk中的模式匹配是一种高级特性，它可以帮助我们快速定位需要处理的文本内容。例如，下面的命令将匹配以"a"开头和以"e"结尾的单词并输出它们：

```text
echo "apple banana able orange pear" | awk '{ for (i=1; i<=NF; i++) { if ($i ~ /^a.*e$/) print $i } }'
```

输出结果为"apple"和"able"，因为它们都是以"a"开头和"e"结尾的。

### 处理结构化数据

awk还可以处理结构化数据，例如CSV文件。下面的例子将读取一个CSV文件并计算第一列的总和：

```text
awk -F, '{s+=$1} END {print s}' file.csv
```

其中，-F参数指定了分隔符为逗号。

### 使用数组

awk支持使用数组来处理数据。下面的例子将计算每个单词在输入中出现的次数并输出它们：

```text
echo "apple banana orange pear apple" | awk -F' ' '{for (i=1; i<=NF; i++) count[$i]++} END {for (i in count) print i, count[i]}'
```

输出结果为：

```text
apple 2
banana 1
orange 1
pear 1
```

其中，count数组用于保存每个单词出现的次数，for循环用于遍历数组并输出结果。

使用数组来实现对数据的统计和分析：

假设有一个名为data.txt的文本文件，其内容如下：

```text
apple 10
banana 20
orange 30
apple 5
orange 15
banana 25
pear 35
pear 20
```

现在我们想要对这些数据进行统计和分析，比如计算每种水果的总数、平均数和最大值。可以使用以下awk命令：

```text
awk '{count[$1]++; sum[$1]+=$2; if (max[$1]<$2) max[$1]=$2} END {for (i in count) printf("%s: count=%d, avg=%.2f, max=%d\n", i, count[i], sum[i]/count[i], max[i])}' data.txt
```

运行结果为：

```text
apple: count=2, avg=7.50, max=10
banana: count=2, avg=22.50, max=25
orange: count=2, avg=22.50, max=30
pear: count=2, avg=27.50, max=35
```

上述awk命令中，我们使用了三个数组：count、sum和max。count数组用于存储每种水果出现的次数，sum数组用于存储每种水果的总数，max数组用于存储每种水果的最大值。在处理每行数据时，我们根据第一列（水果名称）来更新这三个数组。最后，在END块中，我们使用for循环遍历count数组，并计算出每种水果的平均数和最大值，然后输出结果。

### `awk`与`for`结合打印乘法口诀表

```bash
[root@localhost tmp]# awk 'BEGIN {for(i=1;i<=9;i++) {for(j=1;j<=i;j++) printf("%d*%d=%d ",i,j,i*j); printf("\n")}}'

1*1=1 
2*1=2 2*2=4 
3*1=3 3*2=6 3*3=9 
4*1=4 4*2=8 4*3=12 4*4=16 
5*1=5 5*2=10 5*3=15 5*4=20 5*5=25 
6*1=6 6*2=12 6*3=18 6*4=24 6*5=30 6*6=36 
7*1=7 7*2=14 7*3=21 7*4=28 7*5=35 7*6=42 7*7=49 
8*1=8 8*2=16 8*3=24 8*4=32 8*5=40 8*6=48 8*7=56 8*8=64 
9*1=9 9*2=18 9*3=27 9*4=36 9*5=45 9*6=54 9*7=63 9*8=72 9*9=81 

[root@localhost tmp]# 
```

### 2、read

#### 前言

`read` 命令是 Linux/Unix 系统中常用的一个命令，用于从标准输入或其他文件描述符中读取一行数据并将其保存到一个或多个变量中。

`read` 命令的语法格式为：

```bash
read [OPTIONS] [VARIABLE]
```

其中，`OPTIONS` 是一些选项参数，`VARIABLE` 是一个或多个变量名，用于保存输入的数据。

下面是 `read` 命令的一些常用选项：

- `-p`，提示用户输入数据的提示信息；
- `-r`，取消对反斜线的转义，即将反斜线视为普通字符；
- `-s`，隐藏输入的数据，用于输入密码等敏感信息；
- `-a`，将输入的数据保存到数组中，可以使用数组下标来访问数据；
- `-n`，指定读取的字符数；
- `-t`，指定读取的超时时间。

#### 使用说明

下面是 `read` 命令的一些例子：

- 从标准输入读取一个字符串：

```bash
read STR
echo "你输入的字符串是：$STR"
```

- 从标准输入读取一个整数：

```bash
read -p "请输入一个整数：" NUM
if [[ $NUM =~ ^[0-9]+$ ]]; then
  echo "你输入的整数是：$NUM"
else
  echo "输入的不是整数！"
fi
```

- 从标准输入读取一个密码：

```bash
read -s -p "请输入密码：" PASSWORD
echo "你输入的密码是：$PASSWORD"
```

- 从标准输入读取一个包含多个字段的数据，以空格为分隔符：

```bash
read -p "请输入姓名、年龄、性别（以空格分隔）：" NAME AGE GENDER
echo "你输入的信息是：姓名=$NAME，年龄=$AGE，性别=$GENDER"
```

- 从标准输入读取一个数组：

```bash
read -a ARR <<< "1 2 3 4 5"
echo "数组的第一个元素是：${ARR[0]}"
```

总之，`read` 命令是一个非常实用的命令，在编写脚本时经常用到。

### 3、select

#### 前言

`select` 命令是 Bash shell 内置的一种交互式菜单，用于在一系列选项中进行选择。它会在屏幕上显示一组选项，并等待用户输入，一旦用户输入了选项的编号，就会将其作为结果返回。

`select` 命令的语法如下：

```bash
select variable in option1 option2 ... optionN
do
    # commands
done
```

其中，`variable` 是用来存储用户选择的选项编号的变量，`option1` 到 `optionN` 则是用户可以选择的选项列表。执行 `select` 命令时，它会在屏幕上显示选项列表，然后等待用户输入选项的编号。当用户输入编号后，`variable` 变量将会被设置为该编号，然后执行 `do` 和 `done` 之间的命令。

#### 使用说明

下面是一个 `select` 命令的例子：

示例中，有使用到 case 命令

```bash
#!/bin/bash

PS3="请输入你的选择: "

select option in "列表文件" "查看进程" "查看磁盘空间" "退出"
do
    case $option in
        "列表文件")
            ls -l
            ;;
        "查看进程")
            ps -ef
            ;;
        "查看磁盘空间")
            df -h
            ;;
        "退出")
            break
            ;;
        *)
            echo "无效的选项"
            ;;
    esac
done
```

在这个例子中，当用户运行这个脚本时，它会显示一个选项列表，包括列表文件、查看进程、查看磁盘空间和退出。当用户选择一个选项时，会执行相应的命令。如果用户选择了退出选项，脚本会退出 `select` 循环，结束执行。

若菜单项较多，可以先将其定义在一个数组，然后遍历数组。

如何使用数组？演示示例，如下：

例如，我们要重启或停止系统。继续使用`select`命令实现这个功能：

```bash
#!/bin/bash

# 创建一个包含所有操作的列表
options=("重启" "停止")

# 显示菜单
PS3="请选择操作: "
select opt in "${options[@]}"
do
  case $opt in
    "重启")
      echo "正在重启系统..."
      sudo reboot
      ;;
    "停止")
      echo "正在关闭系统..."
      sudo poweroff
      ;;
    *) echo "无效的操作";;
  esac
done
```

在这个例子中，我们首先定义了一个包含操作的列表`options`，然后使用`select`命令显示了一个选择菜单。用户可以输入菜单中的选项编号来选择一个操作。当用户选择一个操作后，使用`case`语句根据用户的选择执行相应的操作。

### 4、case

#### 前言

`case`命令是一个用于处理多个选择的流程控制语句。它可以用于测试一个变量是否等于多个不同的值，并根据不同的值执行不同的操作。`case`命令通常与`esac`结合使用，用于结束`case`语句块。

`case`命令的基本语法如下：

```bash
case variable in
    pattern1)
        command1;;
    pattern2)
        command2;;
    pattern3)
        command3;;
    *)
        default_command;;
esac
```

其中，`variable`为要测试的变量名，`pattern`为匹配的模式，`command`为匹配成功后要执行的命令，`default_command`为没有匹配成功时要执行的默认命令。

#### 使用说明

以下示例，演示了如何使用`case`命令检查用户输入的选项并执行相应的操作：

示例中，有使用到 read 命令，关于 read 命令可参考上面`read`部分

#### 单值选择

```bash
#!/bin/bash

echo "请选择您要进行的操作："
echo "1. 显示当前时间"
echo "2. 显示当前用户"
echo "3. 显示当前目录"

read choice

case $choice in
    1)
        date;;
    2)
        whoami;;
    3)
        pwd;;
    *)
        echo "您输入的选项无效";;
esac
```

在上面的示例中，我们使用`read`命令读取用户的输入，并使用`case`语句检查用户输入的选项。如果用户输入`1`，则打印当前时间；如果用户输入`2`，则打印当前用户；如果用户输入`3`，则打印当前目录；如果用户输入其他选项，则输出一条错误消息。

当脚本运行时，它将显示一个菜单，要求用户选择一个选项。当用户做出选择后，脚本将使用`case`语句检查用户输入的选项，并执行相应的操作。

#### 多值选择

当使用case语句时，通常需要指定一个变量，该变量的值将被用于匹配case中的值。 case语句可以具有多个选项，每个选项都是一个代码块，当变量匹配一个选项时，相应的代码块将被执行。case语句还具有一个可选的默认选项，如果变量的值与所有其他选项都不匹配，则默认选项将被执行。

下面是一个简单的例子，使用case语句检查输入的月份，然后输出该月份所属的季节：

```bash
#!/bin/bash

echo "Enter a month (1-12): "
read month

case $month in
  1|2|12)
    echo "Winter"
    ;;
  3|4|5)
    echo "Spring"
    ;;
  6|7|8)
    echo "Summer"
    ;;
  9|10|11)
    echo "Fall"
    ;;
  *)
    echo "Invalid month"
    ;;
esac
```

在上面的例子中，用户输入一个月份，然后使用case语句进行匹配。如果月份是1、2或12，则输出"冬季"；如果月份是3、4或5，则输出"春季"；如果月份是6、7或8，则输出"夏季"；如果月份是9、10或11，则输出"秋季"。如果月份不在1-12的范围内，则输出"无效的月份"。

------

## 开发编程

1、shell 编程有哪些语法规范？

#### 语法规范

Shell 编程是指使用 Shell 解释器对命令行输入的文本进行解释并执行操作的编程方式。下面是一些 Shell 编程中常见的语法规范：

1. 命名规范：变量名、函数名和文件名应使用小写字母，并用下划线（_）分隔单词，以提高可读性。
2. 注释：在 Shell 脚本中添加注释，有助于他人理解代码，注释应以“#”开头，并用空格隔开注释内容和“#”。
3. 变量：变量名应该尽量简短、具有描述性，且使用时需要加上 $ 符号，如 $VAR。
4. 引号：在使用变量时，最好用双引号括起来，以防止变量中有空格等特殊字符。
5. 条件语句：if-then-else 语句的语法规范为：

```bash
if [ 条件 ]; then
    命令
elif [ 条件 ]; then
    命令
else
    命令
fi
```

6. 循环语句：for 和 while 循环语句的语法规范为：

```bash
# for 循环
for 变量名 in 列表
do
    命令
done

# while 循环
while [ 条件 ]
do
    命令
done
```

7. 函数：函数应该使用 function 关键字定义，并且函数名和括号之间应该有一个空格。

```bash
function 函数名 {
    命令
}
```

这些都是 Shell 编程中常见的语法规范，编写代码时应注意遵守这些规范，以提高代码的可读性和可维护性。

#### 数组&函数

## 2、shell 中数组使用

### 前言

在Shell中，数组是一种数据结构，可以存储多个值。在Shell中，有两种类型的数组：索引数组和关联数组。

#### 1.索引数组

索引数组是一种按照整数索引来访问元素的数组。在Shell中，可以使用以下语法来定义和操作索引数组：

```bash
# 定义一个索引数组
arr=(value1 value2 value3)

# 访问数组元素
echo "${arr[0]}"  # 输出 value1
echo "${arr[1]}"  # 输出 value2
echo "${arr[2]}"  # 输出 value3

# 修改数组元素
arr[1]="new_value"
echo "${arr[1]}"  # 输出 new_value

# 访问整个数组
echo "${arr[@]}"  # 输出 value1 new_value value3

# 访问数组长度
echo "${#arr[@]}"  # 输出 3
```

#### 2.关联数组

关联数组是一种按照字符串索引来访问元素的数组。在Shell中，可以使用以下语法来定义和操作关联数组：

```bash
# 定义一个关联数组
declare -A arr=( [key1]=value1 [key2]=value2 [key3]=value3 )

# 访问数组元素
echo "${arr[key1]}"  # 输出 value1
echo "${arr[key2]}"  # 输出 value2
echo "${arr[key3]}"  # 输出 value3

# 修改数组元素
arr[key2]="new_value"
echo "${arr[key2]}"  # 输出 new_value

# 访问整个数组
echo "${arr[@]}"  # 输出 value1 new_value value3

# 访问数组长度
echo "${#arr[@]}"  # 输出 3
```

#### 总结：

- 数组可以用来存储多个值，并且可以按照整数或字符串索引来访问元素。
- 在Shell中，有两种类型的数组：索引数组和关联数组。
- 索引数组可以使用一系列整数作为索引来访问元素。
- 关联数组可以使用一系列字符串作为索引来访问元素。
- 数组的长度可以使用`${#arr[@]}`来获取。

#### 举例说明：

```bash
# 定义一个索引数组
numbers=(1 2 3 4 5)

# 循环遍历数组
for num in "${numbers[@]}"; do
  echo $num
done

# 输出：
# 1
# 2
# 3
# 4
# 5

# 定义一个关联数组
declare -A fruits=( [apple]="red" [banana]="yellow" [orange]="orange" )

# 输出数组中所有键值对
for key in "${!fruits[@]}"; do
  echo "$key - ${fruits[$key]}"
done

# 输出：
# apple - red
# banana - yellow
# orange - orange
```

以上示例演示了如何定义、访问和遍历数组。在实际使用中，可以使用数组来处理更复杂的数据结构。

### 字符串转数组

#### 使用 {str//,/}

```bash
[root@host ~]# str="ONE,TWO,THREE,FOUR"
[root@host ~]# arr=(${str//,/})
[root@host ~]# echo ${arr[@]}
ONE TWO THREE FOUR
```

#### 使用 tr 命令

```bash
[root@host ~]# str="ONE,TWO,THREE,FOUR"
[root@host ~]# arr=(`echo $str | tr ',' ' '`) 
[root@host ~]# echo ${arr[@]}
ONE TWO THREE FOUR
```

#### 使用 awk 命令

```bash
[root@host ~]# str="ONE,TWO,THREE,FOUR"
[root@host ~]# arr=($(echo $str | awk 'BEGIN{FS=",";OFS=" "} {print $1,$2,$3,$4}'))
[root@host ~]# echo ${str[*]}
```

#### 使用 IFS

```bash
[root@host ~]# str="ONE,TWO,THREE,FOUR"
[root@host ~]# IFS=","
[root@host ~]# arr=(str)
[root@host ~]# echo ${str[@]}
```

### 数组的常用操作

#### 添加

数组可以使用下标进行定义和赋值。下面是一个定义和赋值数组的示例：

```bash
# 定义一个数组
arr=()

# 赋值数组
arr[0]="apple"
arr[1]="banana"
arr[2]="orange"

# 输出数组中所有元素
echo "${arr[@]}"  # 输出 apple banana orange
```

除了使用指定下标来添加数据外，还有一些可以动态添加数据到数组的方法或函数：

`+=`运算符

`+=`运算符可以用来向数组添加元素。例如：

```bash
# 定义一个数组
arr=("apple" "banana" "orange")

# 使用+=添加一个新元素
arr+=("pear")

# 输出添加后的数组
echo "${arr[@]}"  # 输出 apple banana orange pear
```

`array_push`函数

`array_push`函数可以将一个或多个元素添加到数组的末尾。例如：

```bash
# 定义一个数组
arr=("apple" "banana" "orange")

# 使用array_push添加一个新元素
array_push() { arr+=( "$@" ); }
array_push "pear"

# 输出添加后的数组
echo "${arr[@]}"  # 输出 apple banana orange pear
```

`array_unshift`函数

`array_unshift`函数可以将一个或多个元素添加到数组的开头。例如：

```bash
# 定义一个数组
arr=("apple" "banana" "orange")

# 使用array_unshift添加一个新元素
array_unshift() { arr=( "$@" "${arr[@]}" ); }
array_unshift "pear"

# 输出添加后的数组
echo "${arr[@]}"  # 输出 pear apple banana orange
```

需要注意的是，使用以上方法添加的元素位置是固定的，不能在指定位置插入元素。如果需要在指定位置插入元素，还是需要使用指定下标来添加元素。

#### 查询

可以使用下标来访问数组中的元素，也可以使用${array[@]}来访问整个数组。下面是一个访问数组元素的示例：

```bash
# 定义一个数组
arr=("apple" "banana" "orange")

# 访问数组元素
echo "${arr[0]}"  # 输出 apple
echo "${arr[1]}"  # 输出 banana
echo "${arr[2]}"  # 输出 orange

# 访问整个数组
echo "${arr[@]}"  # 输出 apple banana orange
```

除了使用指定下标来访问数组元素外，还有一些函数或方法可以用来查询数组元素：

1. `echo ${array[@]}`

使用`${array[@]}`来输出整个数组，从而查询数组中的所有元素。例如：

```bash
# 定义一个数组
arr=("apple" "banana" "orange")

# 输出整个数组
echo "${arr[@]}"  # 输出 apple banana orange
```

2. `echo ${array[*]}`

使用`${array[*]}`也可以输出整个数组，不同之处在于，`${array[*]}`将数组中所有元素视为单个字符串输出，元素之间使用空格分隔。例如：

```bash
# 定义一个数组
arr=("apple" "banana" "orange")

# 输出整个数组
echo "${arr[*]}"  # 输出 apple banana orange
```

3.`printf '%s\n' "${array[@]}"`

使用`printf`命令和`"${array[@]}"`输出整个数组，每个元素占一行，方便阅读。例如：

```bash
# 定义一个数组
arr=("apple" "banana" "orange")

# 输出整个数组
printf '%s\n' "${arr[@]}"  # 输出 apple banana orange
```

4.`declare -p array`

使用`declare`命令和`-p`选项可以输出数组的定义和赋值情况，包括数组名、元素个数和所有元素的值。例如：

```bash
# 定义一个数组
arr=("apple" "banana" "orange")

# 输出数组的定义和赋值情况
declare -p arr  # 输出 declare -a arr=([0]="apple" [1]="banana" [2]="orange")
```

需要注意的是，以上方法都是用于输出整个数组或者查询所有元素的，无法直接使用来查询特定元素。如果需要查询特定元素，仍然需要使用指定下标的方式进行查询。

#### 修改

可以使用下标来修改数组中的元素，下面是一个修改数组元素的示例：

```bash
# 定义一个数组
arr=("apple" "banana" "orange")

# 修改数组元素
arr[1]="pear"

# 输出修改后的数组
echo "${arr[@]}"  # 输出 apple pear orange
```

除了使用指定下标来修改数组元素外，还有一些函数或方法可以用来修改数组元素：

1. `array_replace`函数

`array_replace`函数可以用来替换数组中指定元素的值。该函数接受两个参数，第一个参数是需要替换的数组，第二个参数是一个关联数组，其中键是需要替换的元素下标，值是新的元素值。例如：

```bash
# 定义一个数组
arr=("apple" "banana" "orange")

# 使用array_replace函数替换一个元素
array_replace() { declare -n _arr="$1"; _arr["$2"]="$3"; }
array_replace arr 1 "pear"

# 输出替换后的数组
echo "${arr[@]}"  # 输出 apple pear orange
```

2.`array_splice`函数

`array_splice`函数可以用来删除数组中的元素，并在指定位置插入新的元素。该函数接受三个参数，第一个参数是需要修改的数组，第二个参数是需要删除的元素下标，第三个参数是需要插入的元素值。例如：

```bash
# 定义一个数组
arr=("apple" "banana" "orange")

# 使用array_splice函数在指定位置替换一个元素
array_splice() { declare -n _arr="$1"; _arr=("${_arr[@]:0:$2}" "$3" "${_arr[@]:$(( $2 + 1 ))}"); }
array_splice arr 1 "pear"

# 输出替换后的数组
echo "${arr[@]}"  # 输出 apple pear orange
```

需要注意的是，以上函数都是需要自己定义的，而不是内置的函数或方法。同时，这些函数的实现需要一定的编程能力。如果不需要进行复杂的数组操作，直接使用指定下标的方式进行修改可能更为简单直接。

以下是`array_replace`和`array_splice`函数的代码定义：

```bash
# array_replace函数的定义
array_replace() {
  # 第一个参数为数组名称，第二个参数为元素下标，第三个参数为新值
  declare -n _arr="$1"
  _arr["$2"]="$3"
}

# array_splice函数的定义
array_splice() {
  # 第一个参数为数组名称，第二个参数为要删除的元素下标，第三个参数为要插入的新值
  declare -n _arr="$1"
  _arr=("${_arr[@]:0:$2}" "$3" "${_arr[@]:$(( $2 + 1 ))}")
}
```

以上代码中，`declare -n`命令用于声明一个引用变量，可以让我们通过变量名来直接操作数组，而不需要使用数组的索引。例如，当我们调用`array_replace arr 1 "pear"`函数时，`declare -n _arr="$1"`会将`_arr`变量绑定到`arr`数组上，然后我们就可以使用`_arr["$2"]="$3"`语句来修改`arr`数组中的元素了。在`array_splice`函数中也是类似的操作，我们将数组切片成三段，然后将新元素插入到中间的那一段。

#### 删除

可以使用`unset`命令删除数组中的元素。下面是一个删除数组元素的示例：

```bash
# 定义一个数组
arr=("apple" "banana" "orange")

# 删除数组元素
unset arr[1]

# 输出删除后的数组
echo "${arr[@]}"  # 输出 apple orange
```

需要注意的是，删除数组元素后，数组的下标不会自动重建，而是保留原有下标。如果需要重建数组下标，可以使用`declare -a`命令重新声明一个新的数组变量。

`array_splice`函数不仅可以用来插入新的元素，还可以用来删除指定位置的元素。只需要将第三个参数设为一个空字符串即可。例如：

```bash
# 定义一个数组
arr=("apple" "banana" "orange")

# 使用array_splice函数删除一个元素
array_splice() { declare -n _arr="$1"; _arr=("${_arr[@]:0:$2}" "" "${_arr[@]:$(( $2 + 1 ))}"); }
array_splice arr 1 ""

# 输出删除后的数组
echo "${arr[@]}"  # 输出 apple orange
```

### 高级用法

Shell中的数组除了常规的定义、赋值、访问、遍历等基础操作外，还有一些高级的用法，下面举几个例子说明：

#### 数组拼接

可以使用`${array1[@]} ${array2[@]}`这样的语法来拼接两个数组。例如：

```bash
# 定义两个数组
arr1=(1 2 3)
arr2=(4 5 6)

# 拼接两个数组
arr3=("${arr1[@]}" "${arr2[@]}")

# 输出拼接后的数组
echo "${arr3[@]}"  # 输出 1 2 3 4 5 6
```

#### 数组截取

可以使用`${array[@]:start_index:length}`这样的语法来截取数组中的一部分。例如：

```bash
# 定义一个数组
arr=(1 2 3 4 5 6 7 8 9)

# 截取数组的一部分
arr2=("${arr[@]:2:5}")

# 输出截取后的数组
echo "${arr2[@]}"  # 输出 3 4 5 6 7
```

#### 数组去重

可以使用`sort`和`uniq`命令来对数组进行去重。例如：

```bash
# 定义一个数组
arr=(1 2 2 3 3 3 4 4 4 4)

# 对数组进行去重
arr2=($(echo "${arr[@]}" | tr ' ' '\n' | sort -u))

# 输出去重后的数组
echo "${arr2[@]}"  # 输出 1 2 3 4
```

在这个例子中，我们首先使用`echo "${arr[@]}"`将数组转换成一行，然后使用`tr ' ' '\n'`将空格替换为换行符，最后使用`sort -u`对行进行排序并去重。

## 3、shell 中函数使用

### 前言

在shell中，我们可以使用两种方式来定义函数：函数声明和函数直接定义。

下面分别介绍这两种方式。

### 使用说明

#### 函数说明

使用`function`关键字和函数名来声明一个函数，然后在花括号内编写函数的代码。语法如下：

```bash
function function_name {
  # 函数代码
}
```

下面是一个例子，它定义了一个名为`say_hello`的函数，用来输出一个问候语：

```bash
function say_hello {
  echo "Hello, world!"
}
```

在脚本的主体中调用这个函数，如下所示：

```text
say_hello
```

执行这个脚本，它将会输出`Hello, world!`。

#### 函数直接定义

另一种方式是使用函数名和花括号直接定义函数，并在花括号内编写函数的代码。语法如下：

```bash
function_name() {
  # 函数代码
}
```

下面是一个例子，它定义了一个名为`get_date`的函数，用来获取当前日期：

```bash
get_date() {
  date "+%Y-%m-%d"
}
```

在脚本的主体中调用这个函数，如下所示：

```bash
today=$(get_date)
echo "Today is $today"
```

执行这个脚本，它将会输出当前的日期，比如`Today is 2023-04-29`。

无论使用哪种方式来定义函数，它们都可以帮助我们在shell脚本中封装一些常用的代码，并提高代码的复用性和可维护性。

------



## 流程控制

## 4、if 判断

### 前言

`if` 是一个流程控制语句，用于基于一个条件的真假决定是否执行一组语句。

if 语句的一般格式如下：

```text
if [ 条件判断语句 ]
then
    执行语句1
    执行语句2
    ...
fi
```

其中 `条件判断语句` 返回真（0）或假（非0）。如果 `条件判断语句` 返回真，则执行 `then` 关键字后的一组语句，否则不执行。

### 使用说明

#### 举例-1（if）

下面是一个使用 `if` 的例子，用于判断用户输入的数字是否大于 10：

```bash
#!/bin/bash
echo "请输入一个数字："
read num

if [ $num -gt 10 ]
then
    echo "$num 大于 10"
fi
```

如果用户输入的数字大于 10，则输出 `$num 大于 10`。如果用户输入的数字小于或等于 10，则不输出任何内容。

#### 举例-2（if）

下面是一个简单的例子，用 `if` 语句来判断一个数是否为偶数：

```bash
#!/bin/bash

echo "Enter a number: "
read num

if ((num % 2 == 0)); then
  echo "$num is even."
else
  echo "$num is odd."
fi
```

这个脚本首先提示用户输入一个数字，然后通过 `read` 命令获取用户的输入。接着，使用 `if` 语句来判断这个数字是否为偶数。如果是偶数，输出提示信息 "X is even."，否则输出 "X is odd."。

注意，在 `if` 语句中，要使用双括号 `(( ))` 来进行数值比较。如果条件成立，则执行 `then` 语句块中的代码，否则执行 `else` 语句块中的代码。在最后，使用 `fi` 关键字来表示 `if` 语句的结束。

#### 举例-3（if else if）

if else if是一种条件控制结构，也称为if-else-if语句。它可以在多个条件之间进行选择，只要有一个条件为真，就会执行相应的代码块。以下是一个使用if else if的例子：

假设我们需要编写一个脚本来根据一个人的年龄段输出不同的消息。假设年龄段分为三类：儿童、青年和中年。根据年龄段输出不同的消息。

可以使用以下代码来实现：

```bash
#!/bin/bash
read -p "请输入你的年龄: " age
if [ $age -lt 18 ]; then
    echo "你还是个孩子，好好学习吧！"
elif [ $age -lt 35 ]; then
    echo "你已经成年了，要为自己的未来打拼！"
else
    echo "你已经是中年人了，要注意身体健康！"
fi
```

在这个例子中，我们使用了 if、elif 和 else 来判断年龄段，并根据不同的年龄段输出不同的消息。如果输入的年龄小于 18，那么输出“你还是个孩子，好好学习吧！”；如果输入的年龄大于等于 18 且小于 35，那么输出“你已经成年了，要为自己的未来打拼！”；如果输入的年龄大于等于 35，那么输出“你已经是中年人了，要注意身体健康！”。

## 5、for循环

### 前言

在shell编程中，for语法可以用于遍历一个列表或者执行一定次数的循环操作。

其语法定义如下

```bash
for 变量名 in 列表
do
    # 循环体
done
```

其中，`变量名`是循环过程中用于迭代遍历的变量，`列表`是待遍历的列表，循环体中的代码将会按照列表中的顺序，每次使用列表中的一个元素来执行。在每次循环过程中，`变量名`都将会被赋值为当前迭代到的列表元素。

### 使用说明

#### 遍历列表

下面是一个遍历列表的例子：

```bash
#!/bin/bash

fruits=("apple" "banana" "cherry" "date")

for fruit in ${fruits[@]}
do
    echo $fruit
done
```

上述代码中，我们定义了一个名为`fruits`的数组，并将其元素初始化为四种水果。然后，我们使用`for`循环来遍历数组中的每一个元素，并将每个元素依次输出到屏幕上。



在shell中，`for`循环还可以用于执行一定次数的循环操作。其语法如下：

```bash
for (( 变量名=起始值; 变量名<=结束值; 变量名++ ))
do
    # 循环体
done
```

其中，`变量名`是用于迭代遍历的变量，`起始值`和`结束值`分别指定了循环过程中`变量名`的取值范围，每次循环`变量名`将会递增1，并执行循环体中的代码。下面是一个打印乘法口诀表的例子：

```bash
#!/bin/bash

for (( i=1; i<=9; i++ ))
do
    for (( j=1; j<=i; j++ ))
    do
        echo -n "$j*$i=$(($j*$i)) "
    done
    echo ""
done
```

上述代码中，我们使用了两个`for`循环来打印乘法口诀表。外层循环控制行数，内层循环控制列数，`echo -n`用于输出字符串，`$((...))`用于执行数学运算。

上述代码会输出：

```bash
1*1=1 
1*2=2 2*2=4 
1*3=3 2*3=6 3*3=9 
1*4=4 2*4=8 3*4=12 4*4=16 
1*5=5 2*5=10 3*5=15 4*5=20 5*5=25 
1*6=6 2*6=12 3*6=18 4*6=24 5*6=30 6*6=36 
1*7=7 2*7=14 3*7=21 4*7=28 5*7=35 6*7=42 7*7=49 
1*8=8 2*8=16 3*8=24 4*8=32 5*8=40 6*8=48 7*8=56 8*8=64 
1*9=9 2*9=18 3*9=27 4*9=36 5*9=45 6*9=54 7*9=63 8*9=72 9*9=81 
```

#### 遍历数组

假设有一个数组，包含了 5 个元素：1、2、3、4、5。我们可以使用 for 循环遍历这个数组，并将每个元素打印出来：

```bash
#!/bin/bash

# 定义数组
array=(1 2 3 4 5)

# 使用 for 循环遍历数组
for i in "${array[@]}"
do
    echo "$i"
done
```

输出结果：

```bash
1
2
3
4
5
```

在上面的例子中，我们先定义了一个名为 array 的数组，包含了 5 个元素。然后我们使用 for 循环遍历这个数组。在 for 循环中，`$i` 表示当前遍历到的元素，`${array[@]}` 表示遍历整个数组。在循环体中，我们使用 `echo` 命令打印出当前元素的值。

#### 遍历字符串

在Shell中，可以使用`for`循环结合`${}`或`$()`的方式遍历字符串。这里提供两种常见的方法：

- 使用`${}`的方式：

```bash
str="hello, world!"
for ((i=0; i<${#str}; i++)); do
    echo ${str:$i:1}
done
```

上述代码中，`${#str}`表示获取字符串`str`的长度。`${str:$i:1}`表示获取字符串`str`中从下标为`$i`的字符开始长度为1的子串。



- 使用`$()`的方式：

```text
str="hello, world!"
for i in $(echo $str | sed -e 's/\(.\)/\1\n/g'); do
    echo $i
done
```

上述代码中，`$(echo $str | sed -e 's/\(.\)/\1\n/g')`表示将字符串`str`中的每个字符都换行输出。`sed -e 's/\(.\)/\1\n/g'`表示将每个字符前面加上`\n`，实现字符换行输出的效果。`for i in $(...)`表示将字符串按照换行符分割为多个子串，并在每个子串上执行循环体。



可以使用 `for` 循环和 `${string:position:length}` 语法来遍历字符串中的每个字符。

下面是一个简单的例子，展示了如何使用 `for` 循环遍历字符串中的每个字符并打印出来：

```bash
#!/bin/bash

string="hello world"

for (( i=0; i<${#string}; i++ )); do
    echo "${string:$i:1}"
done
```

`${#string}` 可以获取字符串的长度。`${string:$i:1}` 获取字符串中从 `$i` 位置开始长度为 `1` 的子字符串，即当前字符。

上述代码会输出：

```text
h
e
l
l
o

w
o
r
l
d
```

如果想要遍历字符串中的每个单词，可以使用 `for` 循环和空格分隔符：

```bash
#!/bin/bash

string="hello world"

for word in $string; do
    echo "$word"
done
```

输出：

```text
hello
world
```

需要注意的是，如果字符串中有空格或其他特殊字符，则需要使用双引号将字符串括起来，否则会将其拆分成多个单词。可以使用 `${parameter//pattern/string}` 语法将字符串中的特殊字符替换为其他字符。例如，下面的代码将所有空格替换为逗号，并打印出替换后的字符串中的每个单词：

```bash
#!/bin/bash

string="hello world"

string=${string// /,}

for word in $string; do
    echo "$word"
done
```

输出：

```text
hello
world
```

### 注意事项

在使用 `for` 循环时，需要注意以下事项：

1. 循环变量定义和使用时需要使用 `$` 符号进行引用，如 `for i in ${arr[@]}`。
2. 如果需要循环输出数字序列，可以使用 `{start..end..increment}` 的语法，如 `for i in {1..10..2}`，表示从1开始，每隔2个数输出一个数字，直到输出10。
3. 如果循环体内部有多个命令需要执行，需要使用 `do` 和 `done` 来定义循环体，如：

```bash
for i in ${arr[@]}
do
    echo "当前元素是：$i"
    # 其他命令
done
```

4. 在循环体内部可以使用 `break` 和 `continue` 控制循环流程，其中 `break` 表示跳出整个循环，`continue` 表示跳过当前迭代并开始下一次迭代。
5. 在使用字符串遍历时，需要注意字符串的引号问题，双引号和单引号的作用不同。如果需要展开变量，需要使用双引号，如 `for i in "${str}"`。

总的来说，在使用 `for` 循环时，需要注意语法的正确性和循环体内部的命令执行情况。

### 扩展

如何将 for 循环变成死循环？

要将for循环变成死循环，可以将循环条件设置为永远为真，即无限循环下去。在shell中，可以使用true命令来实现这个效果，因为true命令总是返回true值，所以将其作为循环条件就可以实现死循环了。

下面是一个使用for循环变成死循环的示例代码：

```bash
for (( ; ; ))
do
    echo "这是一个死循环"
done
```

该代码将会不断输出“这是一个死循环”，因为循环条件永远为真。为了避免无限循环导致系统卡死，可以在需要的时候使用ctrl+c键强制退出循环。

## 6、while循环

### 前言

while 循环是在满足某个条件时，重复执行某段代码。

其语法如下：

```bash
while 条件
do
    待执行的代码块
done
```

当条件为真时，会一直执行代码块，直到条件为假。

### 使用说明

#### 基础使用

以下是一个简单的例子，演示了如何使用 while 循环来输出数字序列：

```bash
#!/bin/bash

# 从 1 开始循环，直到 10
i=1
while [ $i -le 10 ]
do
    echo $i
    # 每次循环，i 自增 1
    i=$(( i + 1 ))
done
```

在这个例子中，while 循环会不断地输出数字序列，直到 i 的值大于 10。每次循环，i 的值会自增 1。

需要注意的是，如果条件一直为真，那么 while 循环将变成死循环。因此，在编写 while 循环时，一定要确保循环条件能够在某个时刻变为假，否则程序将一直运行下去，无法停止。

#### 数字阶乘

下面是一个使用while循环的例子，实现计算输入数字的阶乘：

```bash
#!/bin/bash

echo "请输入一个数字："
read num

result=1
i=1

while [ $i -le $num ]
do
    result=$(expr $result \* $i)
    i=$(expr $i + 1)
done

echo "$num 的阶乘是 $result"
```

首先提示用户输入一个数字，然后使用read命令读取用户输入的数字。接着，我们初始化一个变量`result`为1，表示阶乘的初始值，还有一个变量`i`表示循环的次数。在while循环中，每次循环计算`result`的值，直到`i`的值大于输入的数字`num`时，跳出循环。最后输出计算结果。

#### 乘法口诀

可以使用 while 循环嵌套，逐行打印乘法口诀表。具体实现方法如下

```bash
#!/bin/bash

i=1
while [ $i -le 9 ]
do
  j=1
  while [ $j -le $i ]
  do
    echo -n "$j*$i=$((i*j))  "   # 使用 -n 参数不换行输出
    j=$((j+1))
  done
  echo ""   # 每行结束后需要换行
  i=$((i+1))
done
```

在上述代码中，第一个 while 循环控制行数，第二个 while 循环控制每行中的列数。使用 `-n` 参数可以在输出时不换行，方便控制每行的格式。最后需要在每行结束后使用 `echo ""` 换行。

### 注意事项

在使用 while 循环时，需要注意以下几点：

1. 循环条件：while 循环会在每次循环开始时检查循环条件，只有当循环条件为真时才会执行循环体。因此，需要确保循环条件在循环过程中能够改变，否则会导致死循环。
2. 循环变量的初始化和更新：需要在循环外部对循环变量进行初始化，然后在循环体内对其进行更新。如果在循环体内不对循环变量进行更新，则会导致死循环。
3. 循环体内部的跳出条件：需要在循环体内部定义跳出循环的条件，否则循环会无限执行下去，导致死循环。
4. 循环体内部的代码逻辑：需要保证循环体内部的代码逻辑正确，否则可能会出现不符合预期的结果。

以下是一个使用 while 循环的例子，同时也包括了上述注意事项：

```bash
#!/bin/bash

# 初始化循环变量
count=1

# while 循环，循环条件为 $count 小于等于 10
while [ $count -le 10 ]
do
  echo "count = $count"
  
  # 更新循环变量
  count=$((count + 1))
  
  # 在循环体内部定义跳出循环的条件
  if [ $count -eq 8 ]
  then
    break
  fi
done
```

在这个例子中，使用了 while 循环打印出变量 count 的值，同时在循环体内部定义了跳出循环的条件（当 count 等于 8 时跳出循环）。同时，需要注意在循环体内部对循环变量 count 进行更新，否则会导致死循环。

## 运算符

## 7、算术运算符

### 前言

算术运算符：用于对数值型变量进行算术运算，包括加减乘除、取模和求幂等操作。

- 加法：`+`
- 减法：`-`
- 乘法：`*`
- 除法：`/`
- 取模（取余数）：`%`
- 求幂：`**`

### 使用说明

#### 加法

- 加法运算：

```bash
num1=10
num2=20
sum=$((num1 + num2))
echo "num1 + num2 = $sum"
```

输出：`num1 + num2 = 30`

#### 减法

- 减法运算：

```bash
num1=20
num2=10
sub=$((num1 - num2))
echo "num1 - num2 = $sub"
```

输出：`num1 - num2 = 10` 乘法

#### 乘法

- 乘法运算：

```bash
num1=10
num2=20
product=$((num1 * num2))
echo "num1 * num2 = $product"
```

输出：`num1 * num2 = 200`

#### 除法

- 除法运算：

```bash
num1=20
num2=10
quotient=$((num1 / num2))
echo "num1 / num2 = $quotient"
```

输出：`num1 / num2 = 2`

#### 取模

- 取余数：

```bash
num1=20
num2=10
remainder=$((num1 % num2))
echo "num1 % num2 = $remainder"
```

输出：`num1 % num2 = 0`

#### 求幂

- 求幂

在 Shell 中，可以使用 ** 或 ^ 运算符进行求幂运算。

举个例子，假设我们想计算 2 的 3 次方，可以使用以下命令：

```text
echo $((2 ** 3))
```

或者

```text
echo $((2 ^ 3))
```

执行结果都为 8，即 2 的 3 次方。

## 8、比较运算符

在 Shell 中，常见的比较运算符包括以下几种：

- `-eq`：等于
- `-ne`：不等于
- `-gt`：大于
- `-ge`：大于等于
- `-lt`：小于
- `-le`：小于等于

### 使用说明

#### 等于 `-eq`

```bash
a=10
b=20
if [ $a -eq $b ]
then
   echo "$a 等于 $b"
else
   echo "$a 不等于 $b"
fi
```

输出结果为：

```text
10 不等于 20
```

#### 不等于 `-ne`

```bash
a=10
b=20
if [ $a -ne $b ]
then
   echo "$a 不等于 $b"
else
   echo "$a 等于 $b"
fi
```

输出结果为：

```text
10 不等于 20
```

#### 大于 `-gt`

```bash
a=10
b=20
if [ $a -gt $b ]
then
   echo "$a 大于 $b"
else
   echo "$a 不大于 $b"
fi
```

输出结果为：

```text
10 不大于 20
```

#### 大于等于 `-ge`

```bash
a=10
b=20
if [ $a -ge $b ]
then
   echo "$a 大于等于 $b"
else
   echo "$a 不大于等于 $b"
fi
```

输出结果为：

```text
10 不大于等于 20
```

#### 小于 `-lt`

```bash
a=10
b=20
if [ $a -lt $b ]
then
   echo "$a 小于 $b"
else
   echo "$a 不小于 $b"
fi
```

输出结果为：

```text
10 小于 20
```

#### 小于等于 `-le`

```bash
a=10
b=20
if [ $a -le $b ]
then
   echo "$a 小于等于 $b"
else
   echo "$a 不小于等于 $b"
fi
```

输出结果为：

```text
10 小于等于 20
```

## 9、逻辑运算符

### 前言

在Shell中，逻辑运算符包括 AND、OR、NOT，它们分别表示“与”、“或”、“非”。

### 使用说明

以下是它们的详细说明和使用示例：

示例中有使用到 if 语句

#### AND（与）

表示只有当两个条件都为真时才为真。

在Shell中，AND可以用“-a”、“&&”、“&”来表示，其中“-a”和“&&”等价，而“&”则表示异步执行。

举例：

```bash
if [ $a -gt 10 -a $b -lt 20 ]
then
    echo "a大于10并且b小于20"
fi

if [ $a -gt 10 ] && [ $b -lt 20 ]
then
    echo "a大于10并且b小于20"
fi
```

**& 的扩展**

在 shell 中，& 运算符通常有两个用途：

1. 后台运行命令：在命令结尾加上 & 可以使该命令在后台运行，即使该命令执行了很长时间，你也可以继续使用终端进行其他操作。例如：

```bash
sleep 10 &
这个命令将休眠 10 秒钟，但是加上 & 后，它将在后台运行，你可以继续在终端执行其他命令。 
```

2. 取地址运算符：& 还可以用于取变量的地址，例如：

```bash
x=10
echo $x # 输出 10
echo $(( &x )) # 输出变量 x 的地址
```

这个例子中，&x 将输出变量 x 的地址，而不是它的值。

#### OR（或）

表示只要其中一个条件为真就为真。在Shell中，OR可以用“-o”、“||”来表示。

举例：

```bash
if [ $a -lt 10 -o $b -gt 20 ]
then
    echo "a小于10或者b大于20"
fi

if [ $a -lt 10 ] || [ $b -gt 20 ]
then
    echo "a小于10或者b大于20"
fi
```

#### NOT（非）

表示取反操作，即如果条件为真则返回假，如果条件为假则返回真。在Shell中，NOT可以用“!”来表示。

举例：

```bash
if [ ! $a -gt 10 ]
then
    echo "a不大于10"
fi
```

## 10、字符串运算符

### 前言

字符串运算符：用于对字符串进行比较和连接操作，返回布尔值（0或1）或新的字符串。

- 字符串相等：`=`
- 字符串不相等：`!=`
- 字符串长度不为0：`-n`
- 字符串长度为0：`-z`
- 拼接字符串：`+`

### 使用说明

### 综合示例

下面我们举例说明这些字符串运算符的用法：

```bash
# 判断字符串是否相等
str1="hello"
str2="world"
if [ "$str1" = "$str2" ]; then
    echo "str1 等于 str2"
else
    echo "str1 不等于 str2"
fi

# 判断字符串是否不相等
str1="hello"
str2="world"
if [ "$str1" != "$str2" ]; then
    echo "str1 不等于 str2"
else
    echo "str1 等于 str2"
fi

# 判断字符串是否为空
str=""
if [ -z "$str" ]; then
    echo "str 为空"
else
    echo "str 不为空"
fi

# 判断字符串是否不为空
str="hello"
if [ -n "$str" ]; then
    echo "str 不为空"
else
    echo "str 为空"
fi

# 判断字符串是否为空
str=""
if [ "$str" ]; then
    echo "str 为空"
else
    echo "str 不为空"
fi
```

输出结果为：

```bash
str1 不等于 str2
str1 不等于 str2
str 为空
str 不为空
str 为空
```

从上面的示例中可以看出，字符串运算符可以用于判断两个字符串是否相等或不相等，以及一个字符串是否为空。注意，在判断字符串是否为空时，可以使用`-z`或`str`两种形式。

### 示例详解

- 检查字符串是否相等：

```bash
str1="hello"
str2="world"
if [ "$str1" = "$str2" ]; then
    echo "strings are equal"
else
    echo "strings are not equal"
fi
```

输出结果为：`strings are not equal`

- 检查字符串是否不相等：

```bash
str1="hello"
str2="world"
if [ "$str1" != "$str2" ]; then
    echo "strings are not equal"
else
    echo "strings are equal"
fi
```

输出结果为：`strings are not equal`

- 检查字符串是否为空：

```bash
str=""
if [ -z "$str" ]; then
    echo "string is empty"
else
    echo "string is not empty"
fi
```

输出结果为：`string is empty`

- 检查字符串是否不为空：

```bash
str="hello"
if [ -n "$str" ]; then
    echo "string is not empty"
else
    echo "string is empty"
fi
```

输出结果为：`string is not empty`

- 检查字符串是否包含某个子串：

```bash
str="hello world"
if [[ "$str" == *"hello"* ]]; then
    echo "string contains hello"
else
    echo "string does not contain hello"
fi
```

输出结果为：`string contains hello`

- 检查字符串是否不包含某个子串：

```bash
str="hello world"
if [[ "$str" != *"goodbye"* ]]; then
    echo "string does not contain goodbye"
else
    echo "string contains goodbye"
fi
```

输出结果为：`string does not contain goodbye`

## 11、文件测试运算符

### 前言

Shell中可以使用文件测试运算符来检查文件的状态。以下是常见的文件测试运算符及其含义：

- `-e file`：检查文件是否存在
- `-f file`：检查文件是否为普通文件
- `-d file`：检查文件是否为目录
- `-s file`：检查文件是否为空（大小是否为0）
- `-r file`：检查文件是否可读
- `-w file`：检查文件是否可写
- `-x file`：检查文件是否可执行
- `-L file`：检查文件是否为符号链接
- `file1 -nt file2`：检查文件file1是否比file2新
- `file1 -ot file2`：检查文件file1是否比file2旧

### 使用说明

- `-e 文件名` 测试文件是否存在

例如：

```bash
if [ -e /etc/passwd ]
then
  echo "/etc/passwd 存在"
else
  echo "/etc/passwd 不存在"
fi
```

- `-f 文件名` 测试文件是否是普通文件（不是目录、符号链接等等）

例如：

```bash
if [ -f /etc/passwd ]
then
  echo "/etc/passwd 是一个普通文件"
else
  echo "/etc/passwd 不是一个普通文件"
fi
```

- `-d 文件名` 测试文件是否是目录

例如：

```bash
if [ -d /etc ]
then
  echo "/etc 是一个目录"
else
  echo "/etc 不是一个目录"
fi
```

- `-r 文件名` 测试文件是否可读

例如：

```bash
if [ -r /etc/passwd ]
then
  echo "/etc/passwd 可读"
else
  echo "/etc/passwd 不可读"
fi
```

- `-w 文件名` 测试文件是否可写

例如：

```bash
if [ -w /tmp/test.txt ]
then
  echo "/tmp/test.txt 可写"
else
  echo "/tmp/test.txt 不可写"
fi
```

- `-x 文件名` 测试文件是否可执行

例如：

```bash
if [ -x /usr/bin/vim ]
then
  echo "/usr/bin/vim 可执行"
else
  echo "/usr/bin/vim 不可执行"
fi
```

- `-s 文件名` 测试文件是否非空（大小不为0）

例如：

```bash
if [ -s /var/log/messages ]
then
  echo "/var/log/messages 非空"
else
  echo "/var/log/messages 是空的"
fi
```

假设当前目录下有两个文件：file1和file2，我们可以使用文件测试运算符来比较它们的时间戳，判断哪个文件比另一个文件新或旧。比如：

```bash
# 创建两个空文件file1和file2
touch file1 file2

# 修改文件file1的时间戳
touch -d "yesterday" file1

# 判断file1是否比file2新
if [ file1 -nt file2 ]; then
    echo "file1比file2新"
else
    echo "file2比file1新或它们的时间戳相同"
fi

# 判断file1是否比file2旧
if [ file1 -ot file2 ]; then
    echo "file1比file2旧"
else
    echo "file2比file1旧或它们的时间戳相同"
fi
```

上述代码中，我们首先使用`touch`命令创建了两个空文件`file1`和`file2`。然后，我们通过`touch -d`命令修改了`file1`的时间戳为昨天。接着，我们分别使用`-nt`和`-ot`选项，通过条件语句判断`file1`和`file2`哪个文件比较新或旧，并输出相应的提示信息。

## 知识扩展

### 1、[] 和 [[]] 的区别

下面是`[]`和`[[]]`之间的一些主要区别：

1. 参数扩展：在`[]`中，如果参数中包含通配符，那么它将被扩展为匹配的文件名列表。在`[[]]`中，参数不会被扩展。
2. 字符串比较：在`[]`中，如果使用`=`或`!=`运算符进行字符串比较，则需要将变量用引号引起来，以避免参数拆分和路径扩展。在`[[]]`中，变量不需要引号。
3. 模式匹配：在`[]`中，可以使用通配符进行模式匹配。在`[[]]`中，可以使用更多的模式匹配选项，例如`==`和`=~`。
4. 命令替换：在`[]`中，如果命令替换返回非空值，则条件为真。在`[[]]`中，命令替换需要用`$()`或``````括起来，并且需要将其嵌套在`[[`和`]]`中。

综上所述，`[[]]`提供了更多的语法和功能，而且更加灵活。如果你在Bash Shell中编写脚本，建议优先使用`[[]]`，因为它提供了更多的选项和更好的安全性。但是，如果你需要与其他Shell兼容，则需要使用`[]`。

### 举例

下面是一些具体的例子来说明`[]`和`[[]]`之间的区别：

#### 参数扩展

```bash
# 在 [] 中，参数会被扩展为匹配的文件名列表
$ ls *
file1.txt file2.txt

$ if [ -f file*.txt ]; then echo "true"; fi
true

# 在 [[]] 中，参数不会被扩展
$ if [[ -f file*.txt ]]; then echo "true"; fi
```

#### 字符串比较

```bash
# 在 [] 中，需要用引号括起来，以避免参数拆分和路径扩展
$ var="hello world"
$ if [ "$var" = "hello world" ]; then echo "true"; fi
true

# 在 [[]] 中，不需要引号
$ if [[ $var = hello* ]]; then echo "true"; fi
true
```

### 模糊匹配

```bash
# 在 [] 中，使用通配符进行模式匹配
$ var="hello world"
$ if [ "$var" = "hello*" ]; then echo "true"; fi
false

$ if [ "$var" = "hello*" -o "$var" = "hi*" ]; then echo "true"; fi
true

# 在 [[]] 中，可以使用更多的模式匹配选项
$ if [[ "$var" == hello* ]]; then echo "true"; fi
true

$ if [[ "$var" =~ o.*d ]]; then echo "true"; fi
true
```

### 命令替换

```bash
# 在 [] 中，命令替换返回非空值，则条件为真
$ if [ $(echo "hello") ]; then echo "true"; fi
true

# 在 [[]] 中，命令替换需要用 $() 或 `` 括起来，并且需要将其嵌套在 [[ 和 ]] 中
$ if [[ $(echo "hello") ]]; then echo "true"; fi
true
```