<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class CrsftoRegistro
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure(\Illuminate\Http\Request): (\Illuminate\Http\Response|\Illuminate\Http\RedirectResponse)  $next
     * @return \Illuminate\Http\Response|\Illuminate\Http\RedirectResponse
     */
    public function handle(Request $request, Closure $next)
    {
        
        $response = $next($request);

        if (strpos($request->header('accept'), 'application/json') !== false) {
            $response->headers->set('X-CSRF-TOKEN', csrf_token());
        }

        return $response;
    }
}
