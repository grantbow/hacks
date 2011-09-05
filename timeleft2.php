<?php
$today = getdate();
$event = 1323077400;
printf( "<p>%03.2f hours </p> ", (($event - $today[0]) / 3600 )) ;
printf( "<p>%03.2f days </p> ", (($event - $today[0]) / 86400 ) ) ;
printf( "<p>%03.2f weeks </p> ", (($event - $today[0]) / 604800 ) ) ;
print( "<p><a href=\"http://www.grantbow.com/dreamfish.html\">Thanks for your interest.</a></p> " ) ;
?>

