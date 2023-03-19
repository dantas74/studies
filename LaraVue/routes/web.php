<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\ListingController;
use App\Http\Controllers\ListingOfferController;
use App\Http\Controllers\NotificationController;
use App\Http\Controllers\NotificationSeenController;
use App\Http\Controllers\RealtorListingAcceptOfferController;
use App\Http\Controllers\RealtorListingController;
use App\Http\Controllers\RealtorListingImageController;
use App\Http\Controllers\UserAccountController;
use App\Http\Controllers\VerificationController;
use Illuminate\Http\RedirectResponse;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/', fn(): RedirectResponse => Redirect::route('listing.index'));
Route::get('/hello', fn(): RedirectResponse => Redirect::route('listing.index'));

Route::resource('listing', ListingController::class)
    ->only(['index', 'show']);
//    ->except(['helper', 'function'])
//    ->only(['index', 'show', 'create', 'store', 'edit', 'update', 'destroy']);

Route::get('login', [AuthController::class, 'create'])->name('login');
Route::post('login', [AuthController::class, 'store'])->name('login.store');
Route::delete('logout', [AuthController::class, 'destroy'])->name('logout');

Route::get('email/verify', [VerificationController::class, 'notice'])
    ->middleware('auth')
    ->name('verification.notice');

Route::get('email/verify/{id}/{hash}', [VerificationController::class, 'verify'])
    ->middleware(['auth', 'signed'])
    ->name('verification.verify');

Route::post('email/verification-notification', [VerificationController::class, 'send'])
    ->middleware(['auth', 'throttle:6.1'])
    ->name('verification.send');

Route::resource('user-account', UserAccountController::class)
    ->only(['create', 'store']);

Route::resource('listing.offer', ListingOfferController::class)
    ->middleware('auth')
    ->only(['store']);

Route::resource('notification', NotificationController::class)
    ->middleware('auth')
    ->only(['index']);

Route::put('notification/{notification}/seen', NotificationSeenController::class)
    ->middleware('auth')
    ->name('notification.seen');

Route::prefix('realtor')
    ->name('realtor.')
    ->middleware(['auth', 'verified'])
    ->group(function () {
        Route::name('listing.restore')
            ->put('listing/{listing}/restore', [RealtorListingController::class, 'restore'])
            ->withTrashed();

        Route::resource('listing', RealtorListingController::class)
            ->withTrashed();

        Route::name('offer.accept')->put('offer/{offer}/accept', RealtorListingAcceptOfferController::class);

        Route::resource('listing.image', RealtorListingImageController::class)
            ->only(['create', 'store', 'destroy']);
    });
