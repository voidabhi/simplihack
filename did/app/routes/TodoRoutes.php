<?php

/*
* Todo Routes
*/

return array(
	'/all' => array(
                  'get' => 'Todo:all'
        ),		
	'/:id' => array(
		'post' => 'Todo:index',
		'get' => 'Todo:index'
        ),
	'/add' => array(
                  'get' => 'Todo:all'
        )
);
