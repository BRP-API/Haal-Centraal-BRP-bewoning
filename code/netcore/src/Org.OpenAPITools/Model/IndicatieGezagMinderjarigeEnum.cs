/*
 * Bewoning
 *
 * API voor het zoeken en raadplegen van bewoningen en metagegevens over bewoning (verloop). Een bewoning is een adresseerbaar object (verblijfsobject, ligplaats of standplaats) met ingeschreven bewoner(s). Iedere samenstelling van bewoners van het object is een bewoning. Overleden personen maken onderdeel uit van een bewoning tot het moment van overlijden. Gegevens over de bewoners zijn actueel. 
 *
 * The version of the OpenAPI document: 1.0.0
 * Generated by: https://github.com/openapitools/openapi-generator.git
 */


using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.IO;
using System.Runtime.Serialization;
using System.Text;
using System.Text.RegularExpressions;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using Newtonsoft.Json.Linq;
using System.ComponentModel.DataAnnotations;
using OpenAPIDateConverter = Org.OpenAPITools.Client.OpenAPIDateConverter;

namespace Org.OpenAPITools.Model
{
    /// <summary>
    /// Geeft aan wie het gezag heeft over de minderjarige persoon. * &#x60;ouder1&#x60; - 1 * &#x60;ouder2&#x60; - 2 * &#x60;derden&#x60; - D * &#x60;ouder1_en_derde&#x60; - 1D * &#x60;ouder2_en_derde&#x60; - 2D * &#x60;ouder1_en_ouder2&#x60; - 12 
    /// </summary>
    /// <value>Geeft aan wie het gezag heeft over de minderjarige persoon. * &#x60;ouder1&#x60; - 1 * &#x60;ouder2&#x60; - 2 * &#x60;derden&#x60; - D * &#x60;ouder1_en_derde&#x60; - 1D * &#x60;ouder2_en_derde&#x60; - 2D * &#x60;ouder1_en_ouder2&#x60; - 12 </value>
    
    [JsonConverter(typeof(StringEnumConverter))]
    
    public enum IndicatieGezagMinderjarigeEnum
    {
        /// <summary>
        /// Enum Ouder1 for value: ouder1
        /// </summary>
        [EnumMember(Value = "ouder1")]
        Ouder1 = 1,

        /// <summary>
        /// Enum Ouder2 for value: ouder2
        /// </summary>
        [EnumMember(Value = "ouder2")]
        Ouder2 = 2,

        /// <summary>
        /// Enum Derden for value: derden
        /// </summary>
        [EnumMember(Value = "derden")]
        Derden = 3,

        /// <summary>
        /// Enum Ouder1EnDerde for value: ouder1_en_derde
        /// </summary>
        [EnumMember(Value = "ouder1_en_derde")]
        Ouder1EnDerde = 4,

        /// <summary>
        /// Enum Ouder2EnDerde for value: ouder2_en_derde
        /// </summary>
        [EnumMember(Value = "ouder2_en_derde")]
        Ouder2EnDerde = 5,

        /// <summary>
        /// Enum Ouder1EnOuder2 for value: ouder1_en_ouder2
        /// </summary>
        [EnumMember(Value = "ouder1_en_ouder2")]
        Ouder1EnOuder2 = 6

    }

}