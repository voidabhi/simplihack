
<?php

class Question extends Illuminate\Database\Eloquent\Model {
    public $timestamps = false;
    protected $table = 'question';
    protected $fillable = array('title','keywords','courseid');
}