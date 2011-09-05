<?php
$today = getdate();
$event = 1315314000;
printf( "%03.2f hours",  ($event - $today[0]) / 3600 ) ;
?>

