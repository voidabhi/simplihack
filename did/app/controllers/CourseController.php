<?php 

class CourseController extends \SlimController\SlimController
{
    public function all()
    {
                try{
				$courses= Course::all(); 
				$this->app->response->setBody($courses);
                                }catch(Exception $e){
                    $this->app->response->setBody($e->getMessage());
                }
    }	

}
