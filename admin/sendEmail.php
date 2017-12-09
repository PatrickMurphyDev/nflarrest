<?php
session_start();

//Import the PHPMailer class into the global namespace
use PHPMailer\PHPMailer\PHPMailer;

error_reporting(E_STRICT | E_ALL);

if($_SESSION['auth'] != 1137){
    die('error');
}

date_default_timezone_set('Etc/UTC');

$mail = new PHPMailer;

$body = $_GET['mail_body'];
//$body = file_get_contents('contents.html');

$mail->isSMTP();
$mail->Host = 'mail.nflarrest.com';
$mail->SMTPAuth = true;
$mail->SMTPKeepAlive = true; // SMTP connection will not close after each email sent, reduces SMTP overhead
$mail->Port = 25;
$mail->Username = 'newsletter@nflarrest.com';
$mail->Password = 'FootballArrestSite';
$mail->setFrom('newsletter@nflarrest.com', 'NFLArrest.com');
$mail->addReplyTo('newsletter@nflarrest.com', 'NFLArrest.com');

$mail->Subject = $_GET['mail_subject'];

//Same body for all messages, so set this before the sending loop
//If you generate a different body for each recipient (e.g. you're using a templating system),
//set it inside the loop
$mail->msgHTML($body);
//msgHTML also sets AltBody, but if you want a custom one, set it afterwards
$mail->AltBody = 'To view the message, please use an HTML compatible email viewer!';

//Connect to the database and select the recipients from your mailing list that have not yet been sent to
//You'll need to alter this to match your database
$mysql = mysqli_connect('localhost', 'username', 'password');
mysqli_select_db($mysql, 'mydb');
$result = mysqli_query($mysql, 'SELECT full_name, email, photo FROM mailinglist WHERE sent = FALSE');

foreach ($result as $row) {
    $mail->addAddress($row['email'], $row['full_name']);

    if (!$mail->send()) {
        echo "Mailer Error (" . str_replace("@", "&#64;", $row["email"]) . ') ' . $mail->ErrorInfo . '<br />';
        break; //Abandon sending
    } else {
        echo "Message sent to :" . $row['full_name'] . ' (' . str_replace("@", "&#64;", $row['email']) . ')<br />';
        //Mark it as sent in the DB
        mysqli_query(
            $mysql,
            "UPDATE mailinglist SET sent = TRUE WHERE email = '" .
            mysqli_real_escape_string($mysql, $row['email']) . "'"
        );
    }
    // Clear all addresses and attachments for next loop
    $mail->clearAddresses();
    $mail->clearAttachments();
}
?>