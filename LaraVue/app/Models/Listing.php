<?php

namespace App\Models;

use Database\Factories\ListingFactory;
use Eloquent;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;
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
 * @property Carbon|null $deleted_at
 * @property-read Collection<int, ListingImage> $images
 * @property-read int|null $images_count
 * @property-read Collection<int, Offer> $offers
 * @property-read int|null $offers_count
 * @method static Builder|Listing filters(array $filters)
 * @method static Builder|Listing onlyTrashed()
 * @method static Builder|Listing whereDeletedAt($value)
 * @method static Builder|Listing withTrashed()
 * @method static Builder|Listing withoutTrashed()
 * @mixin Eloquent
 */
class Listing extends Model
{
    use HasFactory, SoftDeletes;

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

    protected $sortable = [
        'price',
        'created_at'
    ];

    public function owner(): BelongsTo
    {
        return $this->belongsTo(User::class, 'owner_id');
    }

    public function images(): HasMany
    {
        return $this->hasMany(ListingImage::class);
    }

    public function offers(): HasMany
    {
        return $this->hasMany(Offer::class);
    }

    public function scopeWithoutSold(Builder $query): Builder
    {
        return $query->whereNull('sold_at');
//            ->doesntHave('offers')
//            ->orWhereHas(
//                'offers',
//                fn(Builder $query) => $query->whereNull('accepted_at')->whereNull('rejected_at')
//            );
    }

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
        )->when(
            $filters['deleted'] ?? false,
            fn($query, $value) => $query->withTrashed()
        )->when(
            $filters['by'] ?? false,
            fn($query, $value) => !in_array($value, $this->sortable)
                ? $query
                : $query->orderBy($value, $filters['order'] ?? 'desc')
        );
    }
}
