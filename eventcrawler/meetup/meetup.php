

<?php
include "../db/connection.php";

function insertEvent($event){

	$query = dbConnect()->prepare("INSERT INTO events (title,url,logo,topic) VALUES (:title, :url,:logo,:topic)");
	
        $query->bindParam(':title', $event['title']);
        $query->bindParam(':url', $event['url']);
        $query->bindParam(':logo', $event['logo']);
		$query->bindParam(':topic', $event['topic']);
        if($query->execute()){
            print("Query exectued successfully!");
        } else{
            print("Some error occurred while executing query!");
        }	
}

$cURL = curl_init();
$topic = 'php';
curl_setopt($cURL, CURLOPT_URL, "https://api.meetup.com/events.json/?topic=".$topic."&page=200&offset=0&key=556e7c243a5d6075553b5147716d5235");
curl_setopt($cURL, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($cURL, CURLOPT_SSL_VERIFYPEER, 0);
$json_string = curl_exec($cURL);
$data= json_decode($json_string);
$eventData =array(
	'title'=>'',
	'url'=>'',
	'logo'=>'',
	'topic'=>''
);
foreach($data->results as $event){
	//print_r($event);

	if(isset($event->name)){
		print($event->name);
		$eventData['title'] = $event->name;
	}
	if(isset($event->event_url)){
		print($event->event_url);
		$eventData['url']= $event->event_url;
	}	
	if(isset($event->photo_url)){
		print($event->photo_url);
		$eventData['logo'] = $event->photo_url;
	}
	$eventData['topic'] = $topic;

	insertEvent($eventData);	
}