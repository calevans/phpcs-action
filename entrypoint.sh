#!/usr/bin/php

<?php
require_once 'vendor/autoload.php';
$executingAction = getenv('GITHUB_ACTIONS') ?? false;
if (!$executingAction) {
  $dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
  $dotenv->load();
} else {
  exec("git log -n 1 --oneline --abbrev-commit --pretty=format:'%h--%d--%s' | awk -F '--' '{print $3}'", $returnValue);
  putenv('COMMIT_MESSAGE=' . $returnValue[0]);
}

$payload = [
  'username' => getenv('SLACK_USERNAME'),
  'icon_url' => getenv('SLACK_ICON'),
  'attachments' =>
  [
    [
      'color' => getenv('SLACK_COLOR'),
      'title' => getenv('GITHUB_REPOSITORY') . ' : ' . getenv('GITHUB_EVENT_NAME'),
      'title_link' => 'https://github.com/' . getenv('GITHUB_REPOSITORY'), // needs more?
      'text' => getenv('COMMIT_MESSAGE'),
      'fields' =>
      [
        [
          'title' => 'Repo',
          'value' => 'https://github.com/' . getenv('GITHUB_REPOSITORY'),
          'short' => false,
        ],
        [
          'title' => 'Event',
          'value' => getenv('GITHUB_EVENT_NAME'),
          'short' => false,
        ]
      ],
    ],
  ],
];

if (getenv('GITHUB_EVENT_NAME') !== 'pull_request') {
  $payload['attachments'][0]['fields'][] = [
    'title' => 'View the Actions',
    'value' => 'https://github.com/' . getenv('GITHUB_REPOSITORY') . '/commit/' . getenv('GITHUB_SHA') . '/checks',
    'short' => false,
  ];

}

$client = new \GuzzleHttp\Client();
$response = $client->request('POST', getenv('SLACK_WEBHOOK'), ['json' => $payload]);

if (!$executingAction) {
  echo "\nStatus Code: " . $response->getStatusCode() . "\n";
}
