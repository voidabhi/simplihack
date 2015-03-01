
<?php

/*
* Question Routes
*/

return array(
    '/q/add' => array(
                'post' =>'Question:addQuestion'
        ),
	'/q/all' => array(
                  'get' => 'Question:all'
        ),
	'/q/:id' => array(
		'post' => 'Question:index',
		'get' => 'Question:index'
        ),
	'/q/u/:username' => array(
		'get' => 'Question:username'
        )
);