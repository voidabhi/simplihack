
<?php

/*
* Teacher Routes
*/

return array(
	'/t/all' => array(
                  'get' => 'Teacher:all'
        ),
	'/t/:id' => array(
		'post' => 'Teacher:index',
		'get' => 'Teacher:index'
        ),
	'/t/u/:username' => array(
		'get' => 'Teacher:username'
        ),		
    '/t/add' => array(
                'post' =>'Teacher:addTeacher'
        )
);