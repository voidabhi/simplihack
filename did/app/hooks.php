<?php 

/**
 * Log request info
 */
$app->hook('log.request.info', function ($msg = null) use ($app) {
	$data = array(
		'Request URL' 		=> $app->request()->getUrl().$app->request()->getPathInfo(),
		'Request referrer' 	=> $app->request()->getReferrer(),
		'Client IP' 		=> $app->request()->getIp(),
		'User Agent' 		=> $app->request()->getUserAgent(),
		'Script name' 		=> $app->request()->getScriptName(),
	);
	$app->log->info($msg, $data);
});

/**
 * Encode body data to Content-Type format
 * @todo handler for all formats
 */
$app->hook('slim.after.dispatch', function () use ($app) {
	$app->response->header('Content-Type', 'application/json');
});

/**
 * Set response as JSON
 */
$app->hook('slim.before.router', function () use ($app) {
	$app->response->header('Content-Type', 'application/json');
});
