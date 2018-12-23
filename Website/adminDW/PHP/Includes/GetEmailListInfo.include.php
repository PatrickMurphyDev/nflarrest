<?php
require_once('PHP/Includes/AdminDatabaseSetup.include.php');

$email_list_result = $db2->query('SELECT referrer, count(1) as `total` FROM `email_list` GROUP BY referrer ORDER BY `total` DESC LIMIT 5');
$email_list = gather_results($email_list_result);

$email_count_result = $db2->query('SELECT COUNT(DISTINCT(`email`)) as `total` FROM `email_list`');
if($email_count_result){
	$email_count = $email_count_result->fetch_assoc();
}else{
	die('<div class="error">'.'DB Connection Error'.'</div>');
}
?>
