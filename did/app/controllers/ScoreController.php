<?php 

class ScoreController extends \SlimController\SlimController
{
	
	public function showScore($studentid,$qid)
	{
                try{
				 $score= Score::whereRaw('studentid = ? and qid = ?', array($studentid,$qid))->first();
				 $this->app->response->setBody($score);
                }catch(Exception $e){
                    $this->app->response->setBody($e->getMessage());
                }		
	}
    
    public function addScore()
    {
               try{
                $scoreParams = $this->app->request->params();
                $response='';
                if(isset($scoreParams['studentid'],$scoreParams['qid'],$scoreParams['score']))
                {
                    Score::create(array(
                                'studentid'=>$scoreParams['studentid'],
								'qid'=>$scoreParams['qid'],
								'score'=>$scoreParams['score']
                            ));
                   $response = '{"message":"Score Posted"}';
                }
                else {
                    $response = '{"message":"Score Not Posted. Incomplete form!"}';
                }
                $this->app->response->setBody($response);
                                }catch(Exception $e){
                    $this->app->response->setBody($e->getMessage());
                }
    }
}
