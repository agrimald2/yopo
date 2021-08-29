<?php

namespace App\Http\Controllers;

use App\ProductOption;
use App\ProductQuestion;
use Illuminate\Http\Request;

class ProductQuestionController extends Controller
{
    public function addQuestion(Request $request)
    {
        $validated = $request->validate([
            'question' => 'required|string'
        ]);

        return ProductQuestion::create($validated);
    }


    public function addOption(Request $request)
    {
        $request->validate([
            'question_id' => 'required|numeric',
            'option' => 'required|string',
        ]);

        $question = ProductQuestion::findOrFail($request->question_id);

        return $question->options()->create(['option' => $request->option]);
    }

    public function removeQuestion(Request $request)
    {
        $request->validate([
            'id' => 'required|numeric',
        ]);

        $question = ProductQuestion::findOrFail($request->id);

        $question->options->each->delete();

        $question->delete();
    }

    public function removeOption(Request $request)
    {
        $request->validate([
            'id' => 'required|numeric',
        ]);

        return ProductOption::findOrFail($request->id)->delete();
    }
}
