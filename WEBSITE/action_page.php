<!DOCTYPE html>
<html>
 <head>
 </head>
 <body>


<?php
echo $_GET["query1"];
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
$find= strtolower($_GET["query1"]);
$query = "SELECT name FROM faculty WHERE LOWER(faculty.responsibility) LIKE '%". $find. "%'";

echo '<br/>'. $query. '<br/>';
?>
</div>
<div id="container2">
<ul>
<?php
mysqli_query($db, $query) or die('Error querying database.');

//Step3
$result = mysqli_query($db, $query);

while ($row = mysqli_fetch_array($result)) {
?>
<li>
<?php
 echo $row['name'] .'<br />';
?>
</li>
<?php
}
//Step 4

mysqli_close($db);
?>
</ul>
</div>

<a href=".">Back</a>
</body>
</html>

