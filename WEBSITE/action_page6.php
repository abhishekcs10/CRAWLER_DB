<!DOCTYPE html>
<html>
 <head>
 </head>
 <body>


<?php
?>


 <h1>PHP connect to MySQL</h1>
<div id="container1">
<?php
$db = mysqli_connect("127.0.0.1", "root", "Password#1", "CSEIITKGP");

if (!$db) {
    echo "Error: Unable to connect to MySQL." . PHP_EOL;
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;
    exit;
}

$query="select name from faculty, (select query1.f_id as mat from (select f_id,count(*) as con from projects GROUP BY f_id) query1 , (select max(query2.count_phd) as highest from (select f_id as f_id,count(*) as count_phd from projects GROUP BY f_id) query2) query3 where query1.con=query3.highest)ans where ans.mat=faculty.id";
//Step2

echo '<br/>'. $query. '<br/>';
?>
</div>
<div id=container2">
<ul>
<?php

mysqli_query($db, $query) or die('Error querying database.');

//Step3
$result = mysqli_query($db, $query);
if(mysqli_num_rows($result) > 0 )
{
while ($row = mysqli_fetch_array($result)) {
?>
<li>
<?php
 echo $row['name'] .'<br />';
?>
</li>
<?php
}
}
//Step 4
mysqli_close($db);
?>
</ul>
</div>

<a href=".">Back</a>
</body>
</html>

