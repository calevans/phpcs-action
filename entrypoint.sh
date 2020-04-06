#!/usr/bin/php

<?php
require_once 'vendor/autoload.php';
$executingAction = getenv('GITHUB_ACTIONS')??false;
if (!$executingAction) {
  $dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
  $dotenv->load();
  $commitMessage = getenv('COMMIT_MESSAGE');
} else {
  exec("git log -n 1 --oneline --abbrev-commit --pretty=format:'%h--%d--%s' | awk -F '--' '{print $3}'", $returnValue);
  $commitMessage = $returnValue[0];
}

$text = "*Reference*\n  " . getenv('GITHUB_REF') . "\n" .
        "*Event*\n  " . getenv('GITHUB_EVENT_NAME') . "\n" .
        "*Commit*\n  " . "https://github.com/" . getenv('GITHUB_REPOSITORY') . '/' . getenv('GITHUB_SHA') . "/commit\n" .
        "*Message*\n  " . $commitMessage . "\n";

$payload = [
  'attachments ' => [
    'text' =>'This is the attachment *TEXT* field.',
    'mrkdwn_in' => ['text'],
    'author_name' => getenv('SLACK_USERNAME'),
    'title' => 'This is the attachment *TITLE* field',
    'fields' => [
      [
        'title' => 'Reference',
        'value' => getenv('GITHUB_REF'),
        'short' => false
      ],
      [
        'title' => 'Event',
        'value' => getenv('GITHUB_EVENT_NAME'),
        'short' => false
      ],
      [
        'title' => 'Commit',
        'value' => "https://github.com/" . getenv('GITHUB_REPOSITORY') . '/' . getenv('GITHUB_SHA') . "/commit\n",
        'short' => false
      ],
      [
        'title' => 'Message',
        'value' =>  $commitMessage ,
        'short' => false
      ],
    ]
  ],
  'username' => getenv('SLACK_USERNAME'),
  'icon_url' => getenv('SLACK_ICON')
];

$client = new \GuzzleHttp\Client();
$response = $client->request('POST', getenv('SLACK_WEBHOOK'),['json'=>$payload]);
