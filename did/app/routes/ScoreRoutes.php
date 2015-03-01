
<?php

/*
* Question Routes
*/

return array(
    '/c/add' => array(
                'post' =>'Score:addScore'
        ),
	'/c/:studentid/:qid' => array(
		'post' => 'Score:showScore',
		'get' => 'Score:showScore'
        ),
);