<html>
<head>
<title>PHP Calendar like 'cal 2011' </title>
</head>
<body>
<?php
    $months = array("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec");
    $days = array("Su", "M", "T", "W", "Th", "F", "Sa");
    $year = 2011;

    // $cm is the current month, 0 indexed so add one for real month number.
    for ($cm=0; $cm<12; $cm++) {
        $numinmonth = cal_days_in_month(CAL_GREGORIAN, $cm+1, $year);
        $j = gregoriantojd ( $cm+1 , 1, $year );
        $dayofweek = jddayofweek($j, 0);
        //echo "There was $numinmonth days in $months[$cm] $year starting on day of week $dayofweek \n";
        echo "<h2>$months[$cm] $year</h2>\n";

        echo "<table>\n";
        echo "<tr>";
        for ($x=0; $x<7; $x++) {
            echo "<td>$days[$x]</td>";
        }
        echo "</tr>\n";

        $monthday = 1;
        for ($y=0; $y<6; $y++) {
            echo "<tr>";
            for ($x=0; $x<7; $x++) {
                echo "<td>";
                if ( $monthday == 1 && $x >= $dayofweek) { // || $x<=$numinmonth ) {
                    echo "$monthday";
                    $monthday++;
                }
                else if ($monthday > 1 && $monthday <= $numinmonth ) {
                    echo "$monthday";
                    $monthday++;
                }
                echo "</td>";
            }
        echo "</tr>\n";
        }
        echo "</table>\n";
    }
?>

</body>
</html>

