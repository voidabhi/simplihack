<?php 

class QuestionController extends \SlimController\SlimController
{
    public function index($id)
    {
                try{
		 $question = Question::find($id); 
		 $this->app->response->setBody($question);
                }catch(Exception $e){
                    $this->app->response->setBody($e->getMessage());
                }
    }
	
	public function username($username)
	{
                try{
				 $question = Question::where('courseid', '=', $username)->get();
				 $this->app->response->setBody($question);
                }catch(Exception $e){
                    $this->app->response->setBody($e->getMessage());
                }		
	}
	
    public function all()
    {
                try{
				$questions= Question::all(); 
				$this->app->response->setBody($questions);
                                }catch(Exception $e){
                    $this->app->response->setBody($e->getMessage());
                }
    }	
    
    public function addQuestion()
    {
				$this->app->response->setBody("Adding Question");
                try{
                $questionParams = $this->app->request->params();
                $response='';
                if(isset($questionParams['title'],$questionParams['keywords'],$questionParams['courseid']))
                {
                    Question::create(array(
                                'title'=>$questionParams['title'],
								'keywords'=>$questionParams['keywords'],
								'courseid'=>$questionParams['courseid']
                            ));
                   $response = '{"message":"Question Created"}';
                }
                else {
                    $response = '{"message":"Question Not Created. Incomplete Form!"}';
                }
                $this->app->response->setBody($response);
                                }catch(Exception $e){
                    $this->app->response->setBody($e->getMessage());
                }
    }
}
