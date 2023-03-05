<?php

namespace App\Models;

use Database\Factories\ListingFactory;
use Eloquent;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Support\Carbon;

/**
 * App\Models\Listing
 *
 * @property int $id
 * @property Carbon|null $created_at
 * @property Carbon|null $updated_at
 * @property int $beds
 * @property int $baths
 * @property int $area
 * @property string $city
 * @property string $code
 * @property string $street
 * @property string $street_nr
 * @property int $price
 * @property int $owner_id
 * @property-read User $owner
 * @method static ListingFactory factory($count = null, $state = [])
 * @method static Builder|Listing newModelQuery()
 * @method static Builder|Listing newQuery()
 * @method static Builder|Listing query()
 * @method static Builder|Listing whereArea($value)
 * @method static Builder|Listing whereBaths($value)
 * @method static Builder|Listing whereBeds($value)
 * @method static Builder|Listing whereCity($value)
 * @method static Builder|Listing whereCode($value)
 * @method static Builder|Listing whereCreatedAt($value)
 * @method static Builder|Listing whereId($value)
 * @method static Builder|Listing whereOwnerId($value)
 * @method static Builder|Listing wherePrice($value)
 * @method static Builder|Listing whereStreet($value)
 * @method static Builder|Listing whereStreetNr($value)
 * @method static Builder|Listing whereUpdatedAt($value)
 * @mixin Eloquent
 */
class Listing extends Model
{
    use HasFactory;

    protected $fillable = [
        'beds',
        'baths',
        'area',
        'city',
        'code',
        'street',
        'street_nr',
        'price'
    ];

    public function owner(): BelongsTo
    {
        return $this->belongsTo(User::class, 'owner_id');
    }

    // To use is in syntax $query->filters()
    public function scopeFilters(Builder $query, array $filters): Builder
    {
        return $query->when(
            $filters['priceFrom'] ?? false,
            fn($query, $value) => $query->where('price', '>=', $value)
        )->when(
            $filters['priceTo'] ?? false,
            fn($query, $value) => $query->where('price', '<=', $value)
        )->when(
            $filters['beds'] ?? false,
            fn($query, $value) => $query->where('beds', (int)$value < 6 ? '=' : '>=', $value)
        )->when(
            $filters['baths'] ?? false,
            fn($query, $value) => $query->where('baths', (int)$value < 6 ? '=' : '>=', $value)
        )->when(
            $filters['areaFrom'] ?? false,
            fn($query, $value) => $query->where('area', '>=', $value)
        )->when(
            $filters['areaTo'] ?? false,
            fn($query, $value) => $query->where('area', '<=', $value)
        );
    }
}
