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

//Step2
$query =  $find;

echo '<br/>'. $query. '<br/>';
?>
</div>
<div id=container2">
<?php
mysqli_query($db, $query) or die('Error querying database.');

//Step3
$result = mysqli_query($db, $query);
if(mysqli_num_rows($result) > 0 )
{
while ($row = mysqli_fetch_array($result)) {
 echo $row['name'] .'<br />';
}
}
//Step 4
echo "Here";
mysqli_close($db);
?>
</div>

<a href=".">Back</a>
</body>
</html>

