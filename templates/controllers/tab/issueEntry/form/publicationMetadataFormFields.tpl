{**
 * templates/controllers/tab/issueEntry/form/publicationMetadataFormFields.tpl
 *
 * Copyright (c) 2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 *}
<script type="text/javascript">
	$(function() {ldelim}
		// Attach the form handler.
		$('#publicationMetadataEntryForm').pkpHandler(
			'$.pkp.controllers.tab.issueEntry.form.IssueEntryPublicationMetadataFormHandler',
			{ldelim}
				trackFormChanges: true,
				arePermissionsAttached: {if $arePermissionsAttached}true{else}false{/if}
			{rdelim}
		);
	{rdelim});
</script>

<form class="pkp_form" id="publicationMetadataEntryForm" method="post" action="{url router=$smarty.const.ROUTE_COMPONENT op="saveForm"}">
	{include file="controllers/notification/inPlaceNotification.tpl" notificationId="publicationMetadataFormFieldsNotification"}

	<input type="hidden" name="submissionId" value="{$submissionId|escape}" />
	<input type="hidden" name="stageId" value="{$stageId|escape}" />
	<input type="hidden" name="tabPos" value="1" />
	<input type="hidden" name="displayedInContainer" value="{$formParams.displayedInContainer|escape}" />
	<input type="hidden" name="tab" value="publication" />
	<input type="hidden" name="waivePublicationFee" value="0" />
	<input type="hidden" name="markAsPaid" value="0" />

	{if !$publicationFeeEnabled || $publicationPayment}
		{fbvFormArea id="schedulingInformation" title="editor.article.scheduleForPublication"}
			{fbvFormSection for="schedule"}
				{if $publishedArticle}
					{assign var=issueId value=$publishedArticle->getIssueId()}
				{else}
					{assign var=issueId value=0}
				{/if}
				{fbvElement type="select" id="issueId" required=true from=$issueOptions selected=$issueId translate=false label="editor.article.scheduleForPublication.toBeAssigned"}
			{/fbvFormSection}
		{/fbvFormArea}

		{if $enablePublicArticleId || $enablePageNumber}
			{fbvFormArea id="customExtras" title="editor.article.customJournalSettings"}
				{fbvFormSection for="customExtras"}
					{if $enablePublicArticleId}
							{if $publishedArticle}
								{assign var=publicArticleId value=$publishedArticle->getPubId('publisher-id')}
							{else}
								{assign var=publicArticleId value=0}
							{/if}
							{fbvElement type="text" id="publicArticleId" label="editor.issues.publicId" value=$publicArticleId inline=true size=$fbvStyles.size.MEDIUM}
					{/if}
					{if $enablePageNumber}
							{if $publishedArticle}
								{assign var=pages value=$publishedArticle->getPages()}
							{else}
								{assign var=pages value=0}
							{/if}
							{fbvElement type="text" id="pages" label="editor.issues.pages" value=$pages inline=true size=$fbvStyles.size.MEDIUM}
					{/if}
				{/fbvFormSection}
			{/fbvFormArea}
		{/if}

		{if $publishedArticle}
			{fbvFormArea id="schedulingInformation" title="editor.issues.published"}
				{fbvFormSection for="publishedDate"}
					{fbvElement type="text" required=true id="datePublished" value=$publishedArticle->getDatePublished()|date_format:$dateFormatShort translate=false label="editor.issues.published" inline=true size=$fbvStyles.size.MEDIUM}
				{if $issueAccess && $issueAccess == $smarty.const.ISSUE_ACCESS_SUBSCRIPTION && $context->getSetting('publishingMode') == $smarty.const.PUBLISHING_MODE_SUBSCRIPTION}
					{fbvElement type="select" id="accessStatus" required=true from=$accessOptions selected=$publishedArticle->getAccessStatus() translate=false label="editor.issues.access" inline=true size=$fbvStyles.size.MEDIUM}
				{/if}
				{/fbvFormSection}
			{/fbvFormArea}
		{/if}
	{else}
		{fbvFormArea id="waivePayment" title="editor.article.payment.publicationFeeNotPaid"}
			{fbvFormSection for="waivePayment" size=$fbvStyles.size.MEDIUM}
				{fbvElement type="button" label="payment.paymentReceived" id="paymentReceivedButton" inline=true}
				{fbvElement type="button" label="payment.waive" id="waivePaymentButton" inline=true}
			{/fbvFormSection}
		{/fbvFormArea}
	{/if}

	{fbvFormArea id="permissions" title="submission.permissions"}
		{fbvFormSection list=true}
			{fbvElement type="checkbox" id="attachPermissions" label="submission.attachPermissions"}
		{/fbvFormSection}
		{fbvFormSection}
			{fbvElement type="text" id="licenseURL" label="submission.licenseURL" value=$licenseURL}
			{fbvElement type="text" id="copyrightHolder" label="submission.copyrightHolder" value=$copyrightHolder multilingual=true size=$fbvStyles.size.MEDIUM inline=true}
			{fbvElement type="text" id="copyrightYear" label="submission.copyrightYear" value=$copyrightYear size=$fbvStyles.size.SMALL inline=true}
		{/fbvFormSection}
	{/fbvFormArea}

	{fbvFormButtons id="publicationMetadataFormSubmit" submitText="common.save"}
</form>
