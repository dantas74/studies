<?php

namespace App\Http\Controllers;

use App\Models\Listing;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Inertia\Response;
use Inertia\ResponseFactory;
use function redirect;

class ListingController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(): Response|ResponseFactory
    {
        $listings = Listing::all();

        return inertia('Listing/Index', [
            'listings' => $listings
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request): RedirectResponse
    {
        Listing::create(
            $request->validate([
                'beds' => 'required|integer|min:0|max:20',
                'baths' => 'required|integer|min:0|max:20',
                'area' => 'required|integer|min:15|max:1500',
                'city' => 'required',
                'code' => 'required',
                'street' => 'required',
                'street_nr' => 'required|integer|min:1',
                'price' => 'required|integer|min:1|max:2000000'
            ])
        );

        return redirect()->route('listing.index')->with('success', 'Listing was created!');
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create(): Response|ResponseFactory
    {
        return inertia('Listing/Create');
    }

    /**
     * Display the specified resource.
     */
    public function show(Listing $listing): Response|ResponseFactory
    {
        return inertia('Listing/Show', [
            'listing' => $listing
        ]);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Listing $listing): Response|ResponseFactory
    {
        return inertia('Listing/Edit', [
            'listing' => $listing
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Listing $listing): RedirectResponse
    {
        $listing->update(
            $request->validate([
                'beds' => 'required|integer|min:0|max:20',
                'baths' => 'required|integer|min:0|max:20',
                'area' => 'required|integer|min:15|max:1500',
                'city' => 'required',
                'code' => 'required',
                'street' => 'required',
                'street_nr' => 'required|integer|min:1',
                'price' => 'required|integer|min:1|max:2000000'
            ])
        );

        return redirect()->route('listing.index')->with('success', 'Listing was changed!');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Listing $listing): RedirectResponse
    {
        $listing->delete();

        return redirect()->back()->with('success', 'Listing was deleted!');
    }
}