<?php

include "../db/connection.php";

function showEvents(){

	$query = dbConnect()->prepare("SELECT * FROM events");
    $query->execute();
	
	$events = array();
        
        while($row = $query->fetch()){
			array_push($events,$row);
        } 	
		
		shuffle($events);
	return $events;
}

$events = showEvents();

?>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Activities</title>

    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
  <body>
  
  <div class="container">
	<h1 class="text-center">Activities</h1>
	<?php
	foreach($events as $event){
		$marker = 'info';
		if(strpos($event[1], 'eventbrite') == TRUE){$marker='danger';}
		elseif(strpos($event[1], 'meetup') == TRUE){$marker='warning';}
	?>
<a href="<?=$event[1]?>" style="text-decoration:none;"><div class="alert alert-dismissible alert-<?=$marker?>">
  <h4><?=$event[0]?></h4>
  
</div></a>
<?php
}
?>

</div>
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
  </body>
</html>