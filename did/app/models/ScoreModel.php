
<?php

class Score extends Illuminate\Database\Eloquent\Model {
    public $timestamps = false;
    protected $table = 'scores';
    protected $fillable = array('studentid','qid','score');
}