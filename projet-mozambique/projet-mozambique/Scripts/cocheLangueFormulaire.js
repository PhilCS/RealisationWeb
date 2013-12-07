function cocheLangueFormulaire(checkbox, langue, prefixe)
{
    var checked = $(checkbox).prop("checked");
    var autreLangue = "FR";

    if (langue == "FR")
        autreLangue = "PT";

    if (!checked && $("#" + prefixe + autreLangue).prop("checked") == false)
    {
        $(checkbox).prop("checked", true);
        cocheLangueFormulaire(checkbox, langue, prefixe);
    }
    else
    {
        var $form = $("#formMultilangue");
        var $validator = $form.validate();

        $("input." + prefixe + langue + ", textarea." + prefixe + langue).each(function ()
        {
            $(this).prop("disabled", !checked);

            // Réinitialiser la validation si la langue est désactivée
            if (!checked)
            {
                $(this).closest("td")
                    .find(".field-validation-error")
                    .removeClass(".field-validation-error")
                    .addClass(".field-validation-valid")
                    .empty();

                $(this).closest("td")
                    .find(".input-validation-error")
                    .removeClass("input-validation-error");
            }
        });
    }
}
