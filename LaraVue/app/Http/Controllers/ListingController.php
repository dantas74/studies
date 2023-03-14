<?php

namespace App\Http\Controllers;

use App\Models\Listing;
use Illuminate\Http\Request;
use Inertia\Response;
use Inertia\ResponseFactory;

class ListingController extends Controller
{
    public function __construct()
    {
        $this->authorizeResource(Listing::class, 'listing');
    }

    /**
     * Display a listing of the resource.
     */
    public function index(Request $request): Response|ResponseFactory
    {
        $options = ['priceFrom', 'priceTo', 'beds', 'baths', 'areaFrom', 'areaTo'];

        $filters = $request->only($options);

        $query = Listing::latest('created_at');


        return inertia('Listing/Index', [
            'filters' => $filters,
            'listings' => $query->filters($filters)->paginate(10)->withQueryString()
        ]);
    }

    /**
     * Display the specified resource.
     */
    public function show(Listing $listing): Response|ResponseFactory
    {
        $listing->load(['images']);

        return inertia('Listing/Show', [
            'listing' => $listing
        ]);
    }
}
