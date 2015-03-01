
<?php

/*
* Student Routes
*/

return array(
	'/s/all' => array(
                  'get' => 'Student:all'
        ),
	'/s/:id' => array(
		'post' => 'Student:index',
		'get' => 'Student:index'
        ),
	'/s/u/:username' => array(
		'get' => 'Student:username'
        ),		
    '/s/add' => array(
                'post' =>'Student:addStudent'
        )
);