<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Notifications\DatabaseNotification;
use Inertia\Response;
use Inertia\ResponseFactory;

class NotificationController extends Controller
{
    public function __construct()
    {
        $this->authorizeResource(DatabaseNotification::class, 'notification');
    }

    public function index(Request $request): Response|ResponseFactory
    {
        return inertia('Notification/Index', [
            'notifications' => $request->user()->notifications()->paginate(10)
        ]);
    }
}
